class LikesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :setup
	
	def create
		@like_manager.like!
		redirect_to :back
	end


	def destroy
		@like_manager.unlike!
		redirect_to :back
	end

	private

	def setup
		
		@post = Post.find(params[:post_id])
		@like_manager = Likes.new(current_user, @post)
	end

end