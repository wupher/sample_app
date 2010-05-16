class UsersController < ApplicationController
  def new
    @title = 'Sign Up'
  end

  def show
    id = 1||params[:id]
    @user = User.find(id)
  end

end
