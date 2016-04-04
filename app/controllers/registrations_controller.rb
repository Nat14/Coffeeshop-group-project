class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

 private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :longitutde, :latitude, :address)
  end

  def account_update_params
    params.require(:user).permit(:password, :password_confirmation, :current_password, :aboutme, :location, :gender, :strength, :weakness, :interests, :home_page_url)
  end
end
