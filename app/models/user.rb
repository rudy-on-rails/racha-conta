class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :accounts_created, class_name: "Account", foreign_key: :user_created_id
  has_many :expenses, foreign_key: "spent_by_user_id"
  has_and_belongs_to_many :shared_accounts, class_name: "Account", join_table: :shared_accounts
  validates_presence_of :name

  def accounts_shared_and_created
  	(accounts_created + shared_accounts)
  end  
end