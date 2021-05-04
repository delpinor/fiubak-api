require 'rom/transformer'

module Persistence
  module Mappers
    class TaskMapper
      def call(tasks)
        tasks.map do |task_attributes|
          user = user_mapper.build_user_from(task_attributes.user)
          task = build_task_from(task_attributes, user)
          task_attributes.tags.each do |tag|
            task.add_tag tag_mapper.build_tag_from(tag)
          end
          task
        end
      end

      def build_task_from(task_attributes, user)
        Task.new(user, task_attributes.title, task_attributes.id)
      end

      def task_changeset(task)
        {title: task.title, user_id: task.user.id, tags: tags_changeset(task)}
      end

      def user_mapper
        UserMapper.new
      end

      def tags_changeset(task)
        tag_mapper.tags_changeset(task)
      end

      def tag_mapper
        TagMapper.new
      end
    end
  end
end
