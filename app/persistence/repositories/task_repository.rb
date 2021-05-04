module Persistence
  module Repositories
    class TaskRepository
      def all
        (task_relation.combine(:tags, :user) >> task_mapper).to_a
      end

      def save(task)
        if task.id.nil?
          create_command = task_relation.command(:create)
          task_record = create_command.call(task_changeset(task))
          task.id = task_record.id
        else
          update_command = task_relation.by_pk(task.id).command(:update)
          update_command.call(task_changeset(task))
        end
        update_tags(task)

        task
      end

      def find(id)
        tasks_relation = task_relation.combine(:tags, :user).by_pk(id)
        task = (tasks_relation >> task_mapper).first
        raise TaskNotFound, "Task with id [#{id}] not found" if task.nil?

        task
      end

      def delete_all
        tags_tasks_relation.command(:delete).call
        task_relation.command(:delete).call
      end

      def delete(task)
        task_relation.by_pk(task.id).command(:delete).call
      end

      private

      def update_tags(task)
        tags_tasks_relation.where(task_id: task.id).delete
        task.tags.each do |tag|
          updated_tag = tag_repo.save(tag)
          tags_tasks_relation.command(:create).call(tag_task_changeset(updated_tag, task))
        end
      end

      def task_changeset(task)
        task_mapper.task_changeset(task)
      end

      def tag_changeset(tag)
        tag_mapper.tag_changeset(tag)
      end

      def tag_task_changeset(tag, task)
        tag_mapper.tag_task_changeset(tag, task)
      end

      def tags_tasks_relation
        DB.relations[:tags_tasks]
      end

      def task_relation
        DB.relations[:tasks]
      end

      def task_mapper
        Persistence::Mappers::TaskMapper.new
      end

      def tag_mapper
        Persistence::Mappers::TagMapper.new
      end

      def tag_repo
        Persistence::Repositories::TagRepository.new
      end
    end
  end
end
