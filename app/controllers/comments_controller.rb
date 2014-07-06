class CommentsController < ApplicationController
	def create
		@topic = Topic.find(params[:topic_id])
		@post = Post.find(params[:post_id])
		@comments = @post.comments 

		@comment = current_user.comments.build(comment_params)
		@comment.post = @post 
		@new_comment = Comment.new

		authorize @comment
		if @comment.save
			redirect_to [@topic, @post], notice: "Comment was saved successfully."
    	else
      		flash[:error] = @comment.errors.full_messages.join(', ') 
      		redirect_to :back
    	end

	end
	def comment_params
		params.require(:comment).permit(:body, :post_id)
	end
end
