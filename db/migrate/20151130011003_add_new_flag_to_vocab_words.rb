class AddNewFlagToVocabWords < ActiveRecord::Migration
  def change
    add_column :vocab_words, :new_flag, :boolean
  end
end
