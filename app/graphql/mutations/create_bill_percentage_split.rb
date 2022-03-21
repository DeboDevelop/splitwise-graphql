class Mutations::CreateBillPercentageSplit < GraphQL::Schema::Mutation
    description "Create Bill with percentage split"
    null true

    argument :description, String, "Description of the bill", required: true
    argument :amount, Float, "Description of the bill", required: true
    argument :bill_payer, Int, "Id of the bill payer", required: true
    argument :shared_amoung, [Types::SharedAmoungInputType], "Ids and percentage of the people who split the bill", required: true

    field :status, Boolean, "Status of the operation"
    field :errors, [String], "List of errors", null: false

    def resolve(description:, amount:, bill_payer:, shared_amoung:)
        success = true
        total_percentage = 0;
        shared_amoung.each do |sa|
            total_percentage += sa.amount
        end

        if total_percentage >= 100
            return {
                status: false,
                errors: ["Total percentage is equal to or over 100"]
            }
        end

        bill_contributors = []

        shared_amoung.each do |sa|
            contributor_amount = (sa.amount*amount)/100
            bill_contributors.push(BillContribution.new(description: description, user_owed_id: bill_payer, user_owes_id: sa.id, amount: contributor_amount))
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