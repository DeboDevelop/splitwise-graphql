class Mutations::SettleUp < GraphQL::Schema::Mutation
    description "Settle Up an existing bill"
    null true

    argument :receiver_id, Int, "Id of the user receiving money", required: true
    argument :amount, Float, "Description of the bill", required: true
   
    field :status, Boolean, "Status of the operation"
    field :errors, [String], "List of errors", null: false

    def resolve(receiver_id:, amount:)
        begin
            bills = BillContribution.where(user_owed_id: receiver_id, completely_paid: false)
            bills.each do |bill|
                next if amount == 0

                if bill.partialy_paid == false
                    if bill.amount <= amount
                        amount = amount - bill.amount
                        bill.update!(completely_paid: true)
                    elsif bill.amount > amount
                        amount = 0
                        bill.update!(partialy_paid: true, amount_paid: amount)
                    end
                elsif bill.partialy_paid == true
                    if (bill.amount - bill.amount_paid) <= amount
                        amount = amount - bill.amount + bill.amount_paid
                        bill.update!(completely_paid: true, partialy_paid: false, amount_paid: 0)
                    elsif (bill.amount - bill.amount_paid) > amount
                        amount = 0
                        bill.update!(amount_paid: bill.amount_paid + amount)
                    end
                end
            end
            if amount >= 0
                BillContribution.create!(description: "Extra money paid in settle up", user_owed_id: context[:current_user].id, user_owes_id: receiver_id, amount: amount)
            end
        rescue => e
            return {
                status: false,
                errors: [e]
            }
        else
            return {
                status: true,
                errors: []
            }
        end
    end
end