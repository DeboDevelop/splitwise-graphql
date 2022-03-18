class Mutations::CreateBillEqualSplit < GraphQL::Schema::Mutation
    description "Create Bill with equal split"
    null true

    argument :description, String, "Description of the bill", required: true
    argument :amount, Float, "Description of the bill", required: true
    argument :bill_payer, Int, "Id of the bill payer", required: true
    argument :shared_amoung, [Int], "Ids of the people who split the bill", required: true

    field :status, Boolean, "Status of the operation"
    field :errors, [String], "List of errors", null: false

    def resolve(description:, amount:, bill_payer:, shared_amoung:)
        success = true
        if context[:current_user].id != bill_payer
            shared_amoung.push(context[:current_user].id)
        end
        contributor_amount = amount / (shared_amoung.length() + 1)

        bill_contributors = []

        shared_amoung.each do |id|
            bill_contributors.push(BillContribution.new(description: description, user_owed_id: bill_payer, user_owes_id: id, amount: contributor_amount))
        end

        BillContribution.transaction do
            bill_contributors.each do |bc|
                if bc.save
                    puts "Save Bill Contrinbution"
                    puts bc
                else
                    success = false
                    raise ActiveRecord::Rollback
                end
            end
        end
        return {
            status: success,
            errors: []
        }
    end
end