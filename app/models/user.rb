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

  def super_admin?
    true
  end

  cm_admin do
    actions only: []
    cm_index do
      page_title 'User'
      page_description 'View all your User here'
  
      filter [:code], :search, placeholder: 'Search'
  
      column :id
      column :email
      column :name
    end
  end

end
