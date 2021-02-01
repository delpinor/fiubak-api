require 'rom/transformer'

module Persistence
  module Mappers
    class UserMapper
      def call(users)
        users.map do |user|
          build_user_from(user)
        end
      end

      def build_user_from(user_attributes)
        User.new(user_attributes.name, user_attributes.id)
      end
    end
  end
end
