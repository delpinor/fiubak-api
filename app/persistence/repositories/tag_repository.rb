module Persistence
  module Repositories
    class TagRepository < AbstractRepository
      self.table_name = :tags
      self.model_class = 'Tag'

      def find_by_tag_name(tag_name, &when_not_found)
        row = dataset.first(tag_name: tag_name)
        return load_object(row) unless row.nil?
        when_not_found.call
      end

      def find_by_task(task)
        tags_tasks_dataset = DB[:tags_tasks]
        tags_tasks = tags_tasks_dataset.where(task_id: task.id)
        tags = []
        tags_tasks.each do | tag_task |
          tags << find( tag_task[:tag_id])
        end
        tags
      end

      protected
      
      def load_object(a_hash)
        Tag.new(a_hash[:tag_name], a_hash[:id])
      end

      def changeset(tag)
        {
          tag_name: tag.tag_name
        }
      end

    end
  end
end
