class PagesController < ApplicationController


  def index

  end

#this is the method that allows us to show user history if they are not logged in
  def profile

    # get only records from this username 
    usermeetings = Usermeeting.where(user_id: User.find_by_username(params[:username]).id)
    # TODO: this is for sort/ordering meeting on profile page
    meetings = usermeetings.map { |usermeeting| usermeeting.meeting }
    @meetings = meetings.sort_by {|meeting| meeting.time}
    @user = (params[:username])

    #this gives a list of saved words for current user
    if user_signed_in?
      @keywords = current_user.searches
    else
      redirect_to "/users/sign_in"
    end
    ## create a list of meetings with those keywords
  end


end
