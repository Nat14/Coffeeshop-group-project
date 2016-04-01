class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

    def sign_up_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :longitutde, :latitude, :address)
    end
end
