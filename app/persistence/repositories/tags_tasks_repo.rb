module Persistence
  module Repositories
    class TagsTasksRepo < ROM::Repository[:tags_tasks]
      commands :create, update: :by_pk, delete: :by_pk

      def create_tag_task(tag, task)
        create(tag_task_changeset(tag, task))
      end

      def delete_all
        tags_tasks.delete
      end

      private

      def tag_task_changeset(tag, task)
        {tag_id: tag.id, task_id: task.id}
      end

    end
  end
end
