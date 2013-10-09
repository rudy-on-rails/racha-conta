class AddSpentByFieldToExpenses < ActiveRecord::Migration
  def up
  	add_column :expenses, :spent_by_user_id, :integer
  	change_column :expenses, :spent_by_user_id, :integer, null: false
  end

  def down
  	remove_column :expenses, :spent_by_user_id
  end
end
