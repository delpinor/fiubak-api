module Persistence
  module Repositories
    class UserRepo < ROM::Repository[:users]
      commands :create, update: :by_pk, delete: :by_pk

      def all
        (users >> user_mapper).to_a
      end

      def find(id)
        users_relation = (users.by_pk(id) >> user_mapper)
        user = users_relation.one
        raise UserNotFound, "User with id [#{id}] not found" if user.nil?

        user
      end

      def update_user(user)
        update(user.id, user_changeset(user))

        user
      end

      def create_user(user)
        user_struct = create(user_changeset(user))
        user.id = user_struct.id

        user
      end

      def delete_user(user)
        delete(user.id)
      end

      def delete_all
        users.delete
      end

      private

      def user_changeset(user)
        {name: user.name}
      end

      def user_mapper
        Persistence::Mappers::UserMapper.new
      end
    end
  end
end
