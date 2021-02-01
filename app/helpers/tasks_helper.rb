# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module TaskHelper
      def task_repo
        Persistence::Repositories::TaskRepo.new(DB)
      end

      def task_params
        @body ||= request.body.read
        task_json = JSON.parse(@body).symbolize_keys
        task_json[:task].symbolize_keys
      end

      def task_to_json(task)
        task_attributes(task).to_json
      end

      def tasks_to_json(tasks)
        tasks.map { |task| task_attributes(task) }.to_json
      end

      def task_mapper
        Persistence::Mappers::TaskMapper.new
      end

      private

      def task_attributes(task)
        {id: task.id, title: task.title, user_id: task.user.id}
      end
    end

    helpers TaskHelper
  end
end
