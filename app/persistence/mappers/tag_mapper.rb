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

    end
  end
end
