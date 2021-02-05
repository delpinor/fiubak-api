module Persistence
  module Repositories
    class TaskRepo < ROM::Repository[:tasks]
      commands :create, update: :by_pk, delete: :by_pk

      def create_task(task)
        task_struct = create(task_changeset(task))
        task.id = task_struct.id

        task
      end

      def find(id)
        tasks_relation = tasks.combine(:tags, :user).by_pk(id)
        task = (tasks_relation >> task_mapper).first
        raise TaskNotFound, "Task with id [#{id}] not found" if task.nil?

        task
      end

      def delete_all
        tags_tasks_relation.delete
        tasks.delete
      end

      def update_tags(task)
        tags_tasks_relation.where(task_id: task.id).delete
        task.tags.each do |tag|
          tags_tasks_create_command.call(tag_task_changeset(tag, task))
        end
      end

      private

      def tags_tasks_create_command
        tags_tasks_relation.command(:create)
      end

      def tags_tasks_relation
        container.relations[:tags_tasks]
      end

      def task_changeset(task)
        {title: task.title, user_id: task.user.id, tags: tags_changeset(task)}
      end

      def tags_changeset(task)
        task.tags.map(&method(:tag_changeset))
      end

      def tag_changeset(tag)
        {tag_name: tag.tag_name}
      end

      def tag_task_changeset(tag, task)
        {tag_id: tag.id, task_id: task.id}
      end

      def task_mapper
        Persistence::Mappers::TaskMapper.new
      end
    end
  end
end
