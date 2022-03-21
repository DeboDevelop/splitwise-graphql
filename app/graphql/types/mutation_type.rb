module Types
  class MutationType < Types::BaseObject
    field :create_user, Types::UserType, mutation: Mutations::CreateUser
    field :update_user, Boolean, null: false, mutation: Mutations::UpdateUser
    field :delete_user, Boolean, null: false, mutation: Mutations::DeleteUser
    field :login, String, mutation: Mutations::Login
    field :logout, Boolean, mutation: Mutations::Logout
    field :create_bill_equal_split, Boolean, mutation: Mutations::CreateBillEqualSplit
    field :create_bill_percentage_split, Boolean, mutation: Mutations::CreateBillPercentageSplit
    field :create_bill_unequal_split, Boolean, mutation: Mutations::CreateBillUnequalSplit
  end
end
