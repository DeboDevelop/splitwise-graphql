class Mutations::Login < GraphQL::Schema::Mutation
    description "Login for the user"
    null true

    argument :user, Types::LoginInputType, "Login attributes of the user", required: true

    field :session_key, String, "Session key which will be access key of the user"
    field :errors, [String], "List of errors", null: false

    def resolve(user:)
        curr_user = User.where(email: user[:email]).first
        if curr_user.valid_password?(user[:password])
            return {
                session_key: curr_user.session.create.key,
                errors: []
            }
        else
            return {
                session_key: nil,
                errors: curr_user.errors.full_messages
            }
        end
    end
end