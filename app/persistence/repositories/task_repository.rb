module Persistence
  module Repositories
    class TaskRepository < AbstractRepository
      self.table_name = :tasks
      self.model_class = 'Task'

      def save(a_task)
        if find_dataset_by_id(a_task.id).first
          update(a_task).positive?
        else
          !insert(a_task).id.nil?
        end
        save_tags(a_task)
        a_task
      end


      protected

      def save_tags(task)
        # first we need to delete previous relations
        tags_tasks_dataset = DB[:tags_tasks]
        old_tags = tags_tasks_dataset.where(task_id: task.id)
        old_tags.delete
        # now we can create the current relations
        task.tags.each do | tag |
          tag_repo.save(tag)
          tags_tasks_dataset.insert(:task_id => task.id, :tag_id => tag.id)
        end
      end

      def load_object(a_hash)
        user_id = a_hash[:user_id]
        debugger
        user = UserRepository.new.find(user_id)
        Task.new(user, a_hash[:title], a_hash[:id])
      end

      def changeset(task)
        {
          title: task.title,
          user_id: task.user.id
        }
      end
    
    end
  end
end
