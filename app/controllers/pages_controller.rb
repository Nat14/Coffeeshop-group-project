class PagesController < ApplicationController
  def index

  end

  def profile
    @meetings = Meeting.all
  end

end
