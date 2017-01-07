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
    params.require(:user).permit(:taiwan_name, :english_name, :paper, :profile,
                                 :has_graduated, :academic_degree,
                                 :joined_CYCU_at_which_year, :has_spent_how_much_time_at_CYCU)
  end
end
