class CreateUsermeetings < ActiveRecord::Migration
  def change
    create_table :usermeetings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :meeting, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
