class UsersController < ApplicationController

  before_filter :authenticate_user_from_token!

  def deactivate
    user.availability_requests.update_all(active: false)
  end

end
