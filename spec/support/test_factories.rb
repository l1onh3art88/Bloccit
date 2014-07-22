module TestFactories
	def post_without_user(options={})
		post_options = {title: 'Post title', body: 'Post bodies must be pretty long.'}.merge(options)
   		post = Post.new(post_options)
   		post.save
   		post
 	end

 	def authenticated_user
   		email = "email#{rand}@fake.com"
   		user = User.new(email: email, password: 'password')
   		user.skip_confirmation!
   		user.save
   		user
 	end
end