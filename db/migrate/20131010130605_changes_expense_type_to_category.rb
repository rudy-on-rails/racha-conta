class ChangesExpenseTypeToCategory < ActiveRecord::Migration
  def change
  	remove_column :expenses, :expense_type_id
  	add_column :expenses, :category, :string
  end
end