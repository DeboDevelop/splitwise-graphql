class Mutations::Logout < GraphQL::Schema::Mutation
    description "Logout for the user"
    null true

    field :status, Boolean, "Status of the operation"
    field :errors, [String], "List of errors", null: false

    def resolve()
        if Session.where(id: context[:session_id]).destroy_all
            return {
                status: true,
                errors: []
            }
        else
            return {
                status: false,
                errors: curr_user.errors.full_messages
            }
        end
    end
end