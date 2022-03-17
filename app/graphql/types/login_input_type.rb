class Types::LoginInputType < GraphQL::Schema::InputObject
    graphql_name "LoginInputType"
    description "Attributes required to login"

    argument :email, String, "Email of the user", required: true
    argument :password, String, "Password of the user", required: true
end