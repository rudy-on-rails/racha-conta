class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :expense_type_id
      t.integer :expense_group_id, null: false
      t.decimal :value

      t.timestamps
    end
  end
end
