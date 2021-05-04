# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module TagsHelper
      def tag_repo
        Persistence::Repositories::TagRepository.new
      end

      def tag_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def tag_to_json(tag)
        tag_attributes(tag).to_json
      end

      def tag_attributes(tag)
        {id: tag.id, tag_name: tag.tag_name}
      end
    end

    helpers TagsHelper
  end
end
