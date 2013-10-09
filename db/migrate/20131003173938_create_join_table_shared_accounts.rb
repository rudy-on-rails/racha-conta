class CreateJoinTableSharedAccounts < ActiveRecord::Migration
  def change
  	create_table :shared_accounts, id: false do |table|
  		table.integer :user_id, null: false
  		table.integer :account_id, null: false
  	end
  	add_index :shared_accounts, [:user_id, :account_id], :unique => true
  end
end
