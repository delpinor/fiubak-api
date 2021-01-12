module Persistence
  module Repositories
    class UserRepo < ROM::Repository[:users]
      commands :create, update: :by_pk, delete: :by_pk

      def all
        users.map_to(User).to_a
      end

      def find(id)
        user = users.by_pk(id).map_to(User).one
        raise UserNotFound, "User with id [#{id}] not found" if user.nil?

        user
      end

      def update_user(user_id, user_params)
        user = find(user_id)
        updated_user = update(user.id, user_params)
        User.new(updated_user.attributes)
      end

      def create_user(user_params)
        new_user = User.new(user_params)
        create(new_user.attributes)
      end

      def delete_user(user_id)
        user = find(user_id)
        delete(user.id)
      end

      def delete_all
        users.delete
      end
    end
  end
end
