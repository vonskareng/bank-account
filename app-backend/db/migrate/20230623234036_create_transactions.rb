class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.string :account_id
      t.integer :amount
      t.datetime :created_at
    end
  end
end
