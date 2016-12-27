class Dashboard::UsersController < Dashboard::DashboardController
  before_action :find_user, only: [:edit, :update]

  def edit

  end

  def update

  end

  def find_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:cover)
  end
end
