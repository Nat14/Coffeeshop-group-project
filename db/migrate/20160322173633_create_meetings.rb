class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :address
      t.datetime :time
      t.text :subject
      t.boolean :confirm
      t.integer :useridtext

      t.timestamps null: false
    end
  end
end
