class PostsController < ApplicationController

  def index
    @posts = Post.all.all.order("created_at desc").paginate(page: params[:page], per_page:3)
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

end
