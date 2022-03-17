module Types
  class MutationType < Types::BaseObject
    field :create_user, Types::UserType, mutation: Mutations::CreateUser
    field :update_user, Boolean, null: false, mutation: Mutations::UpdateUser
    field :delete_user, Boolean, null: false, mutation: Mutations::DeleteUser
    field :login, Boolean, null: false, mutation: Mutations::Login
  end
end
