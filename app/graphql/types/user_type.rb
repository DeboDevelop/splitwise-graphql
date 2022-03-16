class Types::UserType < Types::BaseObject
  description "User Model containing id, name and email"
  field :id, ID, null: false
  field :name, String, null: false
  field :email, String, null: false
end