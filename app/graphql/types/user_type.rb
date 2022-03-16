class Types::UserType < Types::BaseObject
  description "User Model containing id, name and email"
  field :id, ID, "Id of the user", null: false
  field :name, String, "Name of the user", null: false
  field :email, String, "Email of the user", null: false
end