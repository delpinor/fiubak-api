require 'rom/transformer'

module Persistence
  module Mappers
    class TaskMapper
      def call(tasks)
        tasks.map do |task_attributes|
          user = user_mapper.build_from(task_attributes.user)
          build_from(task_attributes, user)
        end
      end

      def build_from(task_attributes, user)
        Task.new(user, task_attributes.title, task_attributes.id)
      end

      def attributes(task)
        {id: task.id, title: task.title, user_id: task.user.id}
      end

      def changeset(task)
        {title: task.title, user_id: task.user.id}
      end

      def user_mapper
        UserMapper.new
      end
    end
  end
end
