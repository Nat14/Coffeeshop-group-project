class MeetingsController < ApplicationController

  before_action :set_meeting, only: [:edit, :update, :destroy]

  # before_action :authenticate_user!

  # GET /meetings
  # GET /meetings.json

  def index

    if params[:timerange] == 'today'
      # filter meeting records to only show for today
      @meetings = Meeting.where("time >= ?", Time.zone.now.beginning_of_day).where("time <= ?", Time.zone.now.end_of_day)
    elsif params[:timerange] == 'tomorrow'
      @meetings = Meeting.where("time >= ?", Time.zone.tomorrow).where("time <= ?", Time.zone.tomorrow + 1)
    elsif params[:timerange] == 'this week'
      @meetings = Meeting.where("time >= ?", Time.zone.now.beginning_of_day).where("time <= ?", Time.zone.now.end_of_week)
    elsif params[:timerange] == 'this month'
      @meetings = Meeting.where("time >= ?", Time.zone.now.beginning_of_day).where("time <= ?", Time.zone.now.end_of_month)
    else
      @meetings = Meeting.where("time >= ?", Time.zone.now.beginning_of_day)
    end
    @hash = Gmaps4rails.build_markers(@meetings) do |meetings, marker|
     marker.lat meetings.latitude
     marker.lng meetings.longitude
     marker.infowindow meetings.address
   end


  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    @hash = Gmaps4rails.build_markers(@meeting) do |meeting, marker|
       marker.lat meeting.latitude
       marker.lng meeting.longitude
       marker.infowindow meeting.address
    end
    @post = Post.where(meeting: @meeting.id)
  end


  # GET /meetings/new
  def new
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @meeting = current_user.meetings.new
      # @post = current_user.posts.new
    end
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    # create new meeting
    @meeting = current_user.meetings.new(meeting_params)
    # new meeting status as unconfirmed
    @meeting.confirm = false
    # add date and time from params to ruby datetime format
    @meeting.time = (meeting_params[:meetingdate] + " " + @meeting.time.hour.to_s + ":" +@meeting.time.min.to_s + ":00").to_datetime
    # create new join table record
    @usermeetings = Usermeeting.new
    @usermeetings.user_id = current_user.id
    @usermeetings.owner = true
    # create new post
    @post = Post.new
    @post.description = meeting_params[:description]
    @post.user_id = current_user.id

    respond_to do |format|
      if @meeting.save
        @usermeetings.meeting_id = @meeting.id
        @usermeetings.save
        @post.meeting_id = @meeting.id
        @post.save

        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

# this method assumes that the search of teh meetings table does not overlap with the email search. If the meetings search is empty, we search for the email address
  def search
    @meetings = Meeting.basic_search(params[:q])

    if user_signed_in?
      @search = Search.new
      @search.user_id = current_user.id
      if Search.where(user_id: current_user.id).find_by_keyword(params[:q]).nil?
        @search.keyword = params[:q]
        @search.save
      end
    end

    @hash = Gmaps4rails.build_markers(@meetings) do |meetings, marker|
       marker.lat meetings.latitude
       marker.lng meetings.longitude
       marker.infowindow meetings.address
    end

    if !@meetings.empty?
      # found word search in meeting table
      render "index"

    else
      # if not found in meeting table search user table
      @user = User.basic_search(params[:q])
      # found word search in user table
      if !@user.empty?
        @meetings = @user.first.meetings
        redirect_to pages_profile_path(username: @user.first.username)
      else
        redirect_to meetings_path, alert: 'Keyword was not found.'
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update

    respond_to do |format|
      if @meeting.update(meeting_params)
        # update date and time (convert string to datetime) from user to database
        @meeting.update(time: (meeting_params[:meetingdate] + " " + @meeting.time.hour.to_s + ":" +@meeting.time.min.to_s + ":00").to_datetime)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    Usermeeting.find_by_meeting_id(@meeting.id).destroy
    Post.find_by_meeting_id(@meeting.id).destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      if !user_signed_in?
        redirect_to new_user_session_path
      else
        # TODO: when you go to this link http://localhost:3000/meetings/edit it will show error
        @meeting = Meeting.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:address, :time, :subject, :description, :meetingdate, :image)
    end
end
