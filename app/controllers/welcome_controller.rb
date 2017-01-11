class WelcomeController < ApplicationController
  def index
    @notes = Note.all.limit(3).order("created_at asc")
    @posts = Post.all.limit(3).order("created_at desc")
  end
end
