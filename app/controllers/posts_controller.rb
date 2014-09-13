class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
   def index
     @posts = Post.visible_to(current_user).where("posts.created_at > ?", 7.days.ago).paginate(page: params[:page], per_page: 10)
   end
end