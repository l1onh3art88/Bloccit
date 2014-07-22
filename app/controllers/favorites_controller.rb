class FavoritesController < ApplicationController
	def create
		@topic = Topic.find(params[:topic_id])
		@post = @topic.posts.find(params[:post_id])
		favorite = current_user.favorites.build(post: @post)
		authorize favorite
		if favorite.save
			redirect_to [@topic, @post], notice: "Post was favorited successfully."
		else
			flash[:error] = "There was an error favoriting the post. Please try again."
			redirect_to [@topic, @post]
		end
	end
	def destroy
		@topic = Topic.find(params[:topic_id])
		@post = @topic.posts.find(params[:post_id])
		favorite = current_user.favorites.find(params[:id])
		authorize favorite

		if favorite.destroy
			redirect_to [@topic, @post], notice: "Post was unfavorited successfully."
		else
			flash[:error] = "There was an error unfavoriting the post. Please try again."
			redirect_to [@topic, @post]
		end
	end
end
