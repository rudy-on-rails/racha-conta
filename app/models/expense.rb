class Expense < ActiveRecord::Base
  attr_accessible :name, :value, :category
  validates_presence_of :value
  belongs_to :expense_group
  belongs_to :spent_by, class_name: "User", foreign_key: "spent_by_user_id"
end
