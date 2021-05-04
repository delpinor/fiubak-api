module Persistence
  module Repositories
    class UserRepository
      def all
        (user_relation >> user_mapper).to_a
      end

      def find(id)
        users_relation = (user_relation.by_pk(id) >> user_mapper)
        user = users_relation.one
        raise UserNotFound, "User with id [#{id}] not found" if user.nil?

        user
      end

      def save(user)
        if user.id.nil?
          create_command = user_relation.command(:create)
          user_record = create_command.call(user_changeset(user))
          user.id = user_record.id
        else
          update_command = user_relation.by_pk(user.id).command(:update)
          update_command.call(user_changeset(user))
        end

        user
      end

      def delete(user)
        user_relation.by_pk(user.id).command(:delete).call
      end

      def delete_all
        user_relation.command(:delete).call
      end

      private

      def user_relation
        DB.relations[:users]
      end

      def user_changeset(user)
        user_mapper.user_changeset(user)
      end

      def user_mapper
        Persistence::Mappers::UserMapper.new
      end
    end
  end
end
