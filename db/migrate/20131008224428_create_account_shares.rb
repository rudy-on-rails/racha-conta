class CreateAccountShares < ActiveRecord::Migration
  def change
    create_table :account_shares do |t|
      t.string :token, null: false
      t.string :email, null: false
      t.integer :account_id, null: false
      t.timestamps
    end
    add_index :account_shares, :token, unique: true
  end
end
