class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.meeting = Meeting.find(params[:meeting_id])
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.meeting = Meeting.find(params[:meeting_id])
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        # for user to join meeting, create new usermeenting record and also mark owner as false
        if Meeting.find(params[:meeting_id]).usermeetings.find_by_user_id(current_user.id).nil?
          @usermeetings = Usermeeting.new
          @usermeetings.user_id = current_user.id
          @usermeetings.meeting_id = params[:meeting_id]
          @usermeetings.owner = false
          @usermeetings.save
          # mark this meeting to be comfirmed
          Meeting.find(params[:meeting_id]).update(confirm: true)
          format.html { redirect_to @post, notice: 'See you there.' }
        else
          # user unjoin meeting, remove record from usermeeting table
          Meeting.find(params[:meeting_id]).usermeetings.find_by_user_id(current_user.id).destroy
          # if only 1 record left for this meeting id in usermeeting, mark meeting as unconfirmed

          if Usermeeting.where(meeting_id: params[:meeting_id]).count == 1
            # TODO: this record does not change confirm back to false
            Meeting.find(params[:meeting_id]).update(confirm: false)
          end
          format.html { redirect_to @post, notice: 'See you next time.' }
        end
        Meeting.find(params[:meeting_id]).update(confirm: true)
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:description, current_user.id)
    end
end
