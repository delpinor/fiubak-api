# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module UserHelper
      def user_repo
        Persistence::Repositories::UserRepo.new(DB)
      end

      def user_params
        @body ||= request.body.read
        user_json = JSON.parse(@body).symbolize_keys
        user_json[:user].symbolize_keys
      end

      def user_to_json(user)
        user.attributes.to_json
      end

      def users_to_json(users)
        users.map(&:attributes).to_json
      end

      def handle_errors(&block)
        block.call
      rescue UserNotFound => e
        status 404
        {error: e.message}.to_json
      rescue InvalidUser => e
        status 400
        {error: e.message}.to_json
      end
    end

    helpers UserHelper
  end
end
