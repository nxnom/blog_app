class UsersController < ApplicationController
  def show
    @user_id = params[:id]
  end
end
