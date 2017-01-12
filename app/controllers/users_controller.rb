class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users_doctor = User.includes(:images).doctor.has_graduated(false)
    @users_master = User.includes(:images).master.has_graduated(false)
    @users_college = User.includes(:images).college.has_graduated(false)
  end

  def show
    @image = @user.images.last
  end

  def graduates
    @users_doctor = User.includes(:images).doctor.has_graduated(true)
    @users_master = User.includes(:images).master.has_graduated(true)
    @users_college = User.includes(:images).college.has_graduated(true)
  end

  def find_user
    @user = User.includes(:images).find(params[:id])
  end

end
