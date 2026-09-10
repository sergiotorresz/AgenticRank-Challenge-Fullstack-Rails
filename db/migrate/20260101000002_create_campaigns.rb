class CreateCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :campaigns do |t|
      t.string  :name, null: false
      t.text    :description
      t.string  :product, null: false
      t.float   :goal, null: false
      t.integer :annual_rate_bps, null: false
      t.integer :term_months, null: false
      t.string  :status, null: false, default: "open"
      t.date    :closes_on, null: false
      t.timestamps
    end
  end
end
