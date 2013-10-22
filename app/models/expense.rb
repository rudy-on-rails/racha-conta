class Expense < ActiveRecord::Base
	default_scope order('created_at DESC')
  attr_accessible :name, :value, :category
  validates_presence_of :value
  belongs_to :expense_group
  belongs_to :spent_by, class_name: "User", foreign_key: "spent_by_user_id"

  def spent_by?(user)
  	self.spent_by == user
  end

  def can_be_modified_by?(user)
  	expense_group.account.created_by?(user) or self.spent_by?(user)
  end
end
