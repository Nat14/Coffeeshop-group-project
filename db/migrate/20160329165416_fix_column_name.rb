class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :searches, :user_search, :keyword
  end
end
