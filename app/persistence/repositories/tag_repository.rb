module Persistence
  module Repositories
    class TagRepository
      def all
        (tag_relation >> tag_mapper).to_a
      end

      def save(tag)
        if tag.id.nil?
          create_command = tag_relation.command(:create)
          tag_record = create_command.call(tag_changeset(tag))

          tag.id = tag_record.id
        else
          update_command = tag_relation.by_pk(tag.id).command(:update)
          update_command.call(tag_changeset(tag))
        end

        tag
      end

      def find(id)
        tags_relation = (tag_relation.by_pk(id) >> tag_mapper)
        tag = tags_relation.one
        raise TagNotFound, "Tag with id [#{id}] not found" if tag.nil?

        tag
      end

      def find_by_tag_name(name, &when_not_found)
        tags_relation = tag_relation.where(tag_name: name)
        tag = (tags_relation >> tag_mapper).first
        return when_not_found.call if tag.nil? && block_given?

        tag
      end

      def delete_all
        tag_relation.command(:delete).call
      end

      def delete(tag)
        tag_relation.by_pk(tag.id).command(:delete).call
      end

      private

      def tag_relation
        DB.relations[:tags]
      end

      def tag_changeset(tag)
        tag_mapper.tag_changeset(tag)
      end

      def tag_mapper
        Persistence::Mappers::TagMapper.new
      end
    end
  end
end
