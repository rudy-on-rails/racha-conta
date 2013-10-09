class CreateExpenseGroups < ActiveRecord::Migration
  def change
    create_table :expense_groups do |t|
      t.integer :account_id, null: false
      t.datetime :date_closed

      t.timestamps
    end
  end
end
