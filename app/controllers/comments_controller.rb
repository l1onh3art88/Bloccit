class CommentsController < ApplicationController
	respond_to :html, :js
	def create
		
		@post = Post.find(params[:post_id])
		@comments = @post.comments 

		@comment = current_user.comments.build(comment_params)
		@comment.post = @post 
		@new_comment = Comment.new

		authorize @comment
		if @comment.save
			flash[:notice] = "Comment was saved successfully."
    	else
      		flash[:error] = @comment.errors.full_messages.join(', ') 
    	end

    	respond_with(@comment) do |format|
    		format.html {redirect_to [@post.topic, @post]}
    	end
	end

	def destroy
		
		@post = Post.find(params[:post_id])

		@comment = @post.comments.find(params[:id])

		authorize @comment
		if @comment.destroy
			flash[:notice] = "Comment was removed."
		else
			flash[:error] = "Comment couldn't be deleted. Try again."
		end
		respond_with(@comment) do |format|
			format.html {redirect_to [@post.topic, @post] }
		end
	end
	def comment_params
		params.require(:comment).permit(:body, :post_id)
	end
end
