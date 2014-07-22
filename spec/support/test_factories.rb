 def post_without_user(options={})
    post_options = { title: 'Post title', body: 'Post bodies must be pretty long.' }.merge(options)
    post = Post.new(post_options)
    allow(post).to receive(:create_vote)
    post.save
    post
 end