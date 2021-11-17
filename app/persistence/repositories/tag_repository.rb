module Persistence
  module Repositories
    class TagRepository < AbstractRepository
      self.table_name = :tags
      self.model_class = 'Tag'

      def find_by_tag_name(name, &when_not_found)
        row = dataset.first(tag_name: tag_name)
        load_object(row) unless row.nil?
      end

      protected
      def changeset(tag)
        {
          tag_name: tag.tag_name
        }
      end

    end
  end
end
