class CreateVocabWords < ActiveRecord::Migration
  def change
    create_table :vocab_words do |t|
      t.string :word
      t.string :lesson

      t.timestamps null: false
    end
  end
end
