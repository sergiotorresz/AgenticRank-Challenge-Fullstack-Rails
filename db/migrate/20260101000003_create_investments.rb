class CreateInvestments < ActiveRecord::Migration[7.1]
  def change
    create_table :investments do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :investor, null: false, foreign_key: true
      t.float      :amount, null: false
      t.string     :idempotency_key, null: false
      t.timestamps
    end

    add_index :investments, :idempotency_key
  end
end
