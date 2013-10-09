class ExpenseGroup < ActiveRecord::Base
  attr_accessible :date_closed
  has_many :expenses
  belongs_to :account

  def total_expent
  	self.expenses.sum(&:value)
  end

  def close!
  	self.date_closed = DateTime.now
  	self.save!
  end

  def closed?
  	not date_closed.blank?
  end
end