class Types::BillContributionType < Types::BaseObject
    description "Bill Contribution Model containing id, description, user_owes, amount, amount_paid"
    field :id, ID, "Id of the Bill Contribution", null: false
    field :description, String, "Description of the bill", null: false
    field :user, Types::UserType, "User who owes to current user", null: false
    field :amount, Float, "Amount of the bill", null: false
    field :amount_paid, Float, "Amount of the bill already paid", null: false

    def self.visible?(context)
        !!context[:current_user]
    end

    def self.authorized?(object, args, context)
        if args.to_h[:user].to_i == context[:current_user][:id]
            true
        else
            return false, { errors: ["User doesn't have permission"] }
        end
    end
end