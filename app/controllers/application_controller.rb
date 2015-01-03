class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def authenticate_user_from_token!
    logger.info "#{user.authentication_token}, #{params[:token]} - #{Devise.secure_compare(user.authentication_token, params[:token])}"
    if user && params[:token] && Devise.secure_compare(user.authentication_token, params[:token])
      logger.debug "SIGN IN"
      #sign_in user, store: false
    else
      logger.debug "ERROR"
      render status: 403, text: '403 Forbidden'
    end

  end

  def user
    @user ||= User.find(params[:user_id] || params[:id])
  end


end
