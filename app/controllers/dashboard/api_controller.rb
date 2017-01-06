class Dashboard::ApiController < Dashboard::DashboardController
  def image_upload
    @user = User.find(params[:id])
    @image = @user.images.create(params[:image].permit(:image))

    if @image
      render :json => {:status => 'success', :image_url => @image.image.url(:medium)}
    else
      render :json => {:status => 'fail'}
    end
  end


  private

  def img_params
      params.require(:image).permit(:image)
  end
end
