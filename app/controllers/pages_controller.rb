class PagesController < ApplicationController


  def index

  end

  def profile
    @meetings = Meeting.all
    # @searches.user_id = current_user.id
    #this gives a list of saved words for current user
    @keywords = current_user.searches
    ## create a list of meetings with those keywords
    @searches = []
    
    @keywords.each do |word|
      @searches = @searches + Meeting.basic_search(word.user_search)
      @user = User.basic_search(word.user_search)

      @user = User.basic_search(word.user_search)
      if !@user.empty?
        @searches = @searches + @user.first.meetings
      end

    end

  end
end
