class AddPaperclipToMeetings < ActiveRecord::Migration
  def change
    add_attachment :meetings, :image
  end
end
