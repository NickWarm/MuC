class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users_doctor = User.includes(:images).doctor.has_graduated(false).order(joined_CYCU_at_which_year: :desc)
    @users_master = User.includes(:images).master.has_graduated(false).order(joined_CYCU_at_which_year: :desc)
    @users_college = User.includes(:images).college.has_graduated(false).order(joined_CYCU_at_which_year: :desc)
  end

  def show
    @image = @user.images.last
  end

  def graduates
    @users_doctor = User.includes(:images).doctor.has_graduated(true).order(joined_CYCU_at_which_year: :asc)
    @users_master = User.includes(:images).master.has_graduated(true).order(joined_CYCU_at_which_year: :asc)
    @users_college = User.includes(:images).college.has_graduated(true).order(joined_CYCU_at_which_year: :asc)
  end

  def find_user
    @user = User.includes(:images).find(params[:id])
  end

end
