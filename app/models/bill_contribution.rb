class BillContribution < ApplicationRecord
    belongs_to :user_owed, :class_name => 'User', :foreign_key => 'user_owed_id'
    belongs_to :user_owes, :class_name => 'User', :foreign_key => 'user_owes_id'
end
