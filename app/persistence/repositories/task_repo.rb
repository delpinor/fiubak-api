module Persistence
  module Repositories
    class TaskRepo < ROM::Repository[:tasks]
      commands :create, update: :by_pk, delete: :by_pk

      def create_task(task)
        task_struct = create(task_mapper.changeset(task))
        task.id = task_struct.id

        task
      end

      def find(id)
        tasks_relation = tasks.combine(:user).by_pk(id)
        task = (tasks_relation >> task_mapper).first
        raise TaskNotFound, "Task with id [#{id}] not found" if task.nil?

        task
      end

      def delete_all
        tasks.delete
      end

      private

      def task_mapper
        Persistence::Mappers::TaskMapper.new
      end
    end
  end
end
