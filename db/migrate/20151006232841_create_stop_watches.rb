class CreateStopWatches < ActiveRecord::Migration
  def change
    create_table :stop_watches do |t|
      t.string :start
      t.string :stop

      t.timestamps null: false
    end
  end
end
