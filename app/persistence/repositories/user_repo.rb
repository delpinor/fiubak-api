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

      def delete_all
        users.delete
      end
    end
  end
end
