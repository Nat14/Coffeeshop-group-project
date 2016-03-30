class PagesController < ApplicationController


  def index

  end

#this is the method that allows us to show user history if they are not logged in
  def profile

    @meetings = Meeting.all
    @usermeetings = Usermeeting.where(user_id: current_user.id)
    @user = (params[:email])

  end


end
