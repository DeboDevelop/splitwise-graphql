class CreateBillContributions < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_contributions do |t|
      t.string :description, null: false, default: ""
      t.integer :user_owed_id
      t.integer :user_owes_id
      t.float :amount, null: false, default: 0.0
      t.boolean :completely_paid, null: false, default: false
      t.boolean :partialy_paid, null: false, default: false
      t.float :amount_paid, null: false, default: 0.0

      t.timestamps
    end
  end
end
