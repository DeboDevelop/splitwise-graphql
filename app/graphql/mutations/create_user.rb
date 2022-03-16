class Mutations::CreateUser < GraphQL::Schema::Mutation
    description "Signup for the user"
    null true

    argument :user, Types::UserInputType, "User object as input", required: true

    field :user, Types::UserType, "User object"
    field :errors, [String], "List of errors", null: false

    def resolve(user:)
        new_user = User.new(user.to_h)
        if new_user.save!
            return {
                user: new_user,
                errors: []
            }
        else
            return {
                user: nil,
                errors: new_user.errors.full_messages
            }
        end
    end
end