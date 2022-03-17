module Types
  class MutationType < Types::BaseObject
    field :create_user, Types::UserType, mutation: Mutations::CreateUser
    field :update_user, Boolean, null: false, mutation: Mutations::UpdateUser
    field :delete_user, Boolean, null: false, mutation: Mutations::DeleteUser
    field :login, String, mutation: Mutations::Login
    field :logout, Boolean, mutation: Mutations::Logout
  end
end
