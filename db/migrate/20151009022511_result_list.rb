class ResultList < ActiveRecord::Migration
  def change
  	add_column "result_lists", "i_value", "integer"
  end
end
