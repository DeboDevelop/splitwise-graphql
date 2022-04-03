class Mutations::UpdateUser < GraphQL::Schema::Mutation
    description "Update existing user record"
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
        if existing&.update(user.to_h)
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

    def self.visible?(context)
        !!context[:current_user]
    end
end