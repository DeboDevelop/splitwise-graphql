class Types::UserInputType < GraphQL::Schema::InputObject
    graphql_name "UserInputType"
    description "All the attributes needed to create an user"

    argument :name, String, "Name of the user", required: true
    argument :email, String, "Email of the user", required: true
    argument :password, String, "Password of the user", required: true
end