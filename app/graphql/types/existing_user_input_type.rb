class Types::ExistingUserInputType < GraphQL::Schema::InputObject
    graphql_name "ExistingUserInputType"
    description "All the attributes needed to update/delete an user"

    argument :id, ID, "Id of the user", required: true
    argument :name, String, "Name of the user", required: false
    argument :email, String, "Email of the user", required: false
    argument :password, String, "Password of the user", required: false

    def self.visible?(context)
        !!context[:current_user]
    end

    def self.authorized?(object, args, context)
        if args.to_h[:id].to_i == context[:current_user][:id]
            true
        else
            return false, { errors: ["User doesn't have permission"] }
        end
    end
end