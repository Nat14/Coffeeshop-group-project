class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:edit, :update, :destroy]
  # before_action :authenticate_user!


  # GET /meetings
  # GET /meetings.json

  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    @post = Post.find_by_meeting_id(@meeting.id)
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

  def search
    @meetings = Meeting.basic_search(params[:q])
    if !@meetings.empty?
      render "search"
    else
      @user = User.basic_search(params[:q])
      @meetings = @user.first.meetings
      render "search"
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update

    respond_to do |format|
      if @meeting.update(meeting_params)
        Post.find_by_meeting_id(@meeting.id).update(description: meeting_params[:description])
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
      params.require(:meeting).permit(:address, :time, :subject, :confirm, :description)
    end
end
