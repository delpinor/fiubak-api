# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module UserHelper
      def user_repo
        Persistence::Repositories::UserRepository.new
      end

      def user_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def user_to_json(user)
        user_attributes(user).to_json
      end

      def users_to_json(users)
        users.map { |user| user_attributes(user) }.to_json
      end

      private

      def user_attributes(user)
        {id: user.id, name: user.name}
      end

      def user_mapper
        Persistence::Mappers::UserMapper.new
      end
    end

    helpers UserHelper
  end
end
