class ExpenseType < ActiveRecord::Base
  attr_accessible :name
  has_many :expenses
end
