class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :post, index: true, foreign_key: true
      t.integer :score, limit: 1

      t.timestamps null: false
    end
  end
end
