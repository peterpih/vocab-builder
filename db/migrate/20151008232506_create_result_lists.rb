class CreateResultLists < ActiveRecord::Migration
  def change
    create_table :result_lists do |t|
      t.string :sessionid
      t.string :type
      t.string :value
      t.integer :order

      t.timestamps null: false
    end
  end
end
