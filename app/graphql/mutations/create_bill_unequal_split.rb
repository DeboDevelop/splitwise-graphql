class Mutations::CreateBillUnequalSplit < GraphQL::Schema::Mutation
    description "Create Bill with Unequal split"
    null true

    argument :description, String, "Description of the bill", required: true
    argument :amount, Float, "Amount of the bill", required: true
    argument :bill_payer, Int, "Id of the bill payer", required: true
    argument :shared_amoung, [Types::SharedAmoungInputType], "Ids and percentage of the people who split the bill", required: true

    field :status, Boolean, "Status of the operation"
    field :errors, [String], "List of errors", null: false

    def resolve(description:, amount:, bill_payer:, shared_amoung:)
        success = true
        total_amount = 0;
        shared_amoung.each do |sa|
            total_amount += sa.amount
        end

        if total_amount > amount
            return {
                status: false,
                errors: ["Total Amount of bill sharer is more than given amount"]
            }
        end

        bill_contributors = []
        temp_amount = amount
        shared_amoung.each do |sa|
            temp_amount = temp_amount - sa.amount
            bill_contributors.push(BillContribution.new(description: description, user_owed_id: bill_payer, user_owes_id: sa.id, amount: sa.amount))
        end

        BillContribution.transaction do
            bill_contributors.each do |bc|
                if bc.save == false
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