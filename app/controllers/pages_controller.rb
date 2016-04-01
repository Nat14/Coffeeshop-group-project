class PagesController < ApplicationController


  def index

  end

#this is the method that allows us to show user history if they are not logged in
  def profile

    # @meetings = Meeting.all
    usermeetings = Usermeeting.where(user_id: params[:email])
    # TODO: this is for ordering meeting on profile page
    meetings = usermeetings.map { |usermeeting| usermeeting.meeting }
    @meetings = meetings.sort_by {|meeting| meeting.time}
    @user = (params[:email])
    # @searches.user_id = current_user.id
    #this gives a list of saved words for current user
    @keywords = current_user.searches
    ## create a list of meetings with those keywords
  end


end
