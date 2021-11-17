module Persistence
  module Repositories
    class TaskRepository < AbstractRepository
      self.table_name = :tasks
      self.model_class = 'Task'

      protected

      def changeset(task)
        {
          title: task.title
        }
      end
    
    end
  end
end
