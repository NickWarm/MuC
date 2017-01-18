class Dashboard::PostsController < Dashboard::DashboardController
  before_action :authenticate_user!
  before_action :find_post, only: [:edit, :update]

  def new
    @post = current_user.posts.build
    @post_authorities = @post.post_authorities.build
    @users_still_in_college = User.all.has_graduated(false)
  end

  def create
    @post = current_user.posts.build(post_params)
    @users_still_in_college = User.all.has_graduated(false)

    # 把user_id、post_id存入中介表
    params[:editors][:id].each do |editor|
      if !editor.empty?
        @post.post_authorities.build(:user_id => editor)
      end
    end


    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post_authorities = @post.post_authorities.build
    @users_still_in_college = User.all.has_graduated(false)
  end

  def update

    if @post.update(post_params)
        @post.editors = []
        params[:editors][:id].each do |editor|
          if !editor.empty?
            @post.editors << User.find(editor)
          end
        end
      redirect_to @post
    else
      render 'edit'
    end
    
  end

  def destroy
    @post.destroy
  end


  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id,
                                  post_authorities_attributes: [:id, :post_id, :user_id])
  end

end
