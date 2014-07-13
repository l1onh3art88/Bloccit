# @user_like = Likes.new(current_user, @post)
# @user_like.like!
# @user_like.unlike!
# @user_like.liked_posts
# @user_like.liked_posts_count
# @user_like.post_user_likes

class Likes

  # Adding a like to the post key
  def self.user_likes_post(user, post)
    REDIS.multi do
      REDIS.sadd self.post_key(post), user.id
      REDIS.sadd self.user_key(user), post.id
    end
    return true
  end

  # Removing a like from the post key
  def self.user_dislikes_post(user, post)
    REDIS.multi do
      REDIS.srem self.post_key(post), user.id
      REDIS.srem self.user_key(user), post.id
    end
    return true
  end

  # Return total likes count per post
  def self.total_likes_for_post(post)
    REDIS.scard self.post_key(post)
    return true
  end

  # Return all post ids the user liked
  def self.user_liked_posts(user)
    REDIS.scard self.user_key(user)
    return true
  end

  protected

  def self.user_key(user)
    "users:#{user.id}:liked_posts"
  end

  def self.post_key(key)
    "posts:#{post.id}:liking_users"
  end
end