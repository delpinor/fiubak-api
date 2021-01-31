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
        user_mapper.attributes(user).to_json
      end

      def users_to_json(users)
        users.map { |user| user_mapper.attributes(user) }.to_json
      end

      def user_mapper
        Persistence::Mappers::UserMapper.new
      end
    end

    helpers UserHelper
  end
end
