class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  def index
  end

  def create
    @user = User.new
    @user.username = params[:user][:username]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.avatar = params[:user][:avatar]
    @user.save
    redirect_to "/"
    end

    def sign_up_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
