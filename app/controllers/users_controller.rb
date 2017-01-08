class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users_doctor = User.doctor.has_graduated(false)
    @users_master = User.master.has_graduated(false)
    @users_college = User.college.has_graduated(false)
  end

  def show
    @image = @user.images.last
  end

  def graduates
    @users_doctor = User.doctor.has_graduated(true)
    @users_master = User.master.has_graduated(true)
    @users_college = User.college.has_graduated(true)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
