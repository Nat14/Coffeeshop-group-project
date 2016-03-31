class PagesController < ApplicationController


  def index

  end

#this is the method that allows us to show user history if they are not logged in
  def profile

    @meetings = Meeting.all
    # @usermeetings = Usermeeting.where(user_id: current_user.id)
    @usermeetings = Usermeeting.where(user_id: User.find_by_username(params[:username]).id)
    @user = (params[:username])
    # @searches.user_id = current_user.id
    #this gives a list of saved words for current user
    if user_signed_in?
      @keywords = current_user.searches
    else
      redirect_to "/users/sign_in"
    end
    ## create a list of meetings with those keywords
  end


end
