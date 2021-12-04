module Persistence
  module Repositories
    class UserRepository < AbstractRepository
      self.table_name = :users
      self.model_class = 'User'

      protected

      def load_object(a_hash)
        User.new(a_hash[:name], a_hash[:id])
      end

      def changeset(user)
        {
          name: user.name
        }
      end
    end
  end
end
