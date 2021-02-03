module Persistence
  module Repositories
    class TagRepo < ROM::Repository[:tags]
      commands :create, update: :by_pk, delete: :by_pk

      def create_tag(tag)
        tag_struct = create(tag_changeset(tag))
        tag.id = tag_struct.id

        tag
      end

      def find_by_tag_name(name, &when_not_found)
        tags_relation = tags.where(tag_name: name)
        tag = (tags_relation >> tag_mapper).first
        return when_not_found.call if tag.nil? && block_given?

        tag
      end

      def delete_all
        tags.delete
      end

      private

      def tag_changeset(tag)
        {tag_name: tag.tag_name}
      end

      def tag_mapper
        Persistence::Mappers::TagMapper.new
      end
    end
  end
end
