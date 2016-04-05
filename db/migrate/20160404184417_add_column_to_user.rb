class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :aboutme, :string
    add_column :users, :location, :string
    add_column :users, :gender, :string
    add_column :users, :strength, :string
    add_column :users, :weakness, :string
    add_column :users, :interests, :string
    add_column :users, :home_page_url, :string
  end
end
