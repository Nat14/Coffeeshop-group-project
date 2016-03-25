class AddColumnToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :meeting, index: true, foreign_key: true
  end
end
