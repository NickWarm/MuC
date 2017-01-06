class Dashboard::UsersController < Dashboard::DashboardController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:taiwan_name, :english_name, :paper, :profile)
  end
end
