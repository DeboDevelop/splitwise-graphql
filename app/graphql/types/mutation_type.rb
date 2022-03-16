module Types
  class MutationType < Types::BaseObject
    field :create_user, Types::UserType, mutation: Mutations::CreateUser
  end
end
