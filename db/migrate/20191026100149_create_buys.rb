class CreateBuys < ActiveRecord::Migration[5.2]
  def change
    create_table :buys do |t|
      t.integer :item_id 
      t.integer :user_id
      t.integer :point

      t.timestamps
    end
  end
end
