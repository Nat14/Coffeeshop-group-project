class PagesController < ApplicationController


  def index

  end

#this is the method that allows us to show user history if they are not logged in
  def profile

    @meetings = Meeting.all
    @user = (params[:email])

    # @searches.user_id = current_user.id
    #this gives a list of saved words for current user
    @keywords = current_user.searches
    ## create a list of meetings with those keywords
    @searches = []

    @keywords.each do |word|
      @searches = @searches + Meeting.basic_search(word.keyword)
      @user = User.basic_search(word.keyword)

      @user = User.basic_search(word.keyword)
      if !@user.empty?
        @searches = @searches + @user.first.meetings
      end
    end
  end


end
