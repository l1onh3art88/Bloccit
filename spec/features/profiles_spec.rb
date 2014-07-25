require 'rails_helper'

describe "Visiting profiles" do 

	include TestFactories

	before do 
		@user = authenticated_user
		@topic = Topic.create(description: "A topic")
		@post = post_without_user(user: @user, topic: @topic)
		@comment = Comment.new(user: @user, body: "A Comment")
    	allow(@comment).to receive(:send_favorite_emails)
    	@comment.save
	end
	describe "not signed in" do 
		it "shows profile" do 
			visit user_path(@user)
			expect(current_path).to eq (user_path(@user))

       		expect( page ).to have_content(@user.name)
       		expect( page ).to have_content(@post.title)
       		expect( page ).to have_content(@comment.body)
		end
	end
end