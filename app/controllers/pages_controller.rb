class PagesController < ApplicationController


  def index

  end

#this is the method that allows us to show user history if they are not logged in
  def profile

    @meetings = Meeting.all
    @user = (params[:email])

  end


end
