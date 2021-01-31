require 'rom/transformer'

module Persistence
  module Mappers
    class UserMapper
      def call(users)
        users.map do |user|
          build_from(user)
        end
      end

      def build_from(user_attributes)
        User.new(user_attributes.name, user_attributes.id)
      end

      def attributes(user)
        {id: user.id, name: user.name}
      end

      def changeset(user)
        {name: user.name}
      end
    end
  end
end
