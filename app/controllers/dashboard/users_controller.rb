class Dashboard::UsersController < Dashboard::DashboardController
  before_action :find_user, only: [:edit, :update]

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:taiwan_name, :english_name, :paper, :profile)
  end
end
