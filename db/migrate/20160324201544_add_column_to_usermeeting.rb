class AddColumnToUsermeeting < ActiveRecord::Migration
  def change
    add_column :usermeetings, :owner, :boolean
  end
end
