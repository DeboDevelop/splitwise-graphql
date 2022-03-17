class Mutations::DeleteUser < GraphQL::Schema::Mutation
    description "Delete Existing User Record"
    null true

    argument :user, Types::ExistingUserInputType, "User object as input", required: true

    field :status, Boolean, "Status of the operation"
    field :errors, [String], "List of errors", null: false

    def resolve(user:)
        existing = User.where(id: user[:id]).first
        if existing.nil?
            return {
                status: false,
                errors: ["User doesn't exist"]
            }
        end
        if existing.delete
            return {
                status: true,
                errors: []
            }
        else
            return {
                status: false,
                errors: existing.errors.full_messages
            }
        end
    end
end