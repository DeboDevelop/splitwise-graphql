class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_and_belongs_to_many :friends, 
              class_name: "User", 
              join_table: :friendships, 
              foreign_key: :user_id, 
              association_foreign_key: :friend_user_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :session
  has_many :bill_contribution
end
