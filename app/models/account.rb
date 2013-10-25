class Account < ActiveRecord::Base
  attr_accessible :name, :user_created_id
  belongs_to :creator, class_name: "User", foreign_key: :user_created_id
  has_and_belongs_to_many :shared_with, class_name: "User", join_table: :shared_accounts
  has_many :expense_groups, dependent: :restrict
  has_many :expenses, through: :expense_groups
  has_many :account_shares
  validates_presence_of :name

  def find_or_create_a_current_expense_group
  	expense_group = opened_expense_group
  	expense_group ||= self.expense_groups.create
  	expense_group
  end

  def opened_expenses
  	expense_group = opened_expense_group
		if expense_group
  		expense_group.expenses
  	else
  		[]
  	end
  end

  def expenses_of(year)
  	expenses.where("expenses.created_at like ?", "#{year}%")
  end

  def created_by?(user)
  	self.creator == user
  end

  def shared_with?(user)
  	user.accounts_shared_and_created.include?(self)
  end

  def remove_sharing(user)
  	shared_with.delete(user)
  end

  def close_current_group!
  	group = opened_expense_group
  	group.close!
  end

  private
  def opened_expense_group
  	expense_group = expense_groups.select{|eg| not eg.closed?}.first
  end
end
