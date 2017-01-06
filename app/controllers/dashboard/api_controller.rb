class Dashboard::ApiController < Dashboard::DashboardController
  before_action :authenticate_user!

  def image_upload
    @image = current_user.images.create(img_params)

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
