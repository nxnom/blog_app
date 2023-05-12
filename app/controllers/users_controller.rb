class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params['id'])
  end

  private

  def current_user
    User.first
  end
end
