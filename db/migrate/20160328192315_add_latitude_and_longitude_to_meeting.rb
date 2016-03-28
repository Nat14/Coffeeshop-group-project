class AddLatitudeAndLongitudeToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :latitude, :decimal, precision: 10, scale: 6
    add_column :meetings, :longitude, :decimal, precision: 10, scale: 6

  end
end
