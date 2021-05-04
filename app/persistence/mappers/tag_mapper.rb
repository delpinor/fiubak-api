require 'rom/transformer'

module Persistence
  module Mappers
    class TagMapper
      def call(tags)
        tags.map do |tag_attributes|
          build_tag_from(tag_attributes)
        end
      end

      def build_tag_from(tag_attributes)
        Tag.new(tag_attributes.tag_name, tag_attributes.id)
      end

      def tag_changeset(tag)
        {tag_name: tag.tag_name}
      end

      def tag_task_changeset(tag, task)
        {tag_id: tag.id, task_id: task.id}
      end

      def tags_changeset(task)
        task.tags.map(&method(:tag_changeset))
      end
    end
  end
end
