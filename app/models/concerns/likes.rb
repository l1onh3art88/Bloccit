# @user_like = Likes.new(current_user, @post)
# @user_like.like!
# @user_like.unlike!
# @user_like.liked_posts
# @user_like.liked_posts_count
# @user_like.post_user_likes

class Likes

  attr_accessor :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def like!
    REDIS.multi do
      REDIS.sadd post_key, user.id
      REDIS.sadd user_key, post.id
    end
    
    return true
  end

  def unlike!
    REDIS.multi do
      REDIS.srem post_key, user.id
      REDIS.srem user_key, post.id
    end
    return true
  end

  def liked_posts
    REDIS.smembers user_key
  end

  def liked_posts_count
    REDIS.scard user_key
  end

  def post_user_likes
    REDIS.smembers post_key
  end

  def post_likes_count
    REDIS.scard post_key
  end

  def user_liked_post?
    REDIS.sismember post_key, user.id
  end

  protected

  def user_key
    "users:#{user.id}:liked_posts"
  end

  def post_key
    "posts:#{post.id}:liking_users"
  end

  # # Adding a like to the post key
  # def self.user_likes_post(user, post)
  #   REDIS.multi do
  #     REDIS.sadd self.post_key(post), user.id
  #     REDIS.sadd self.user_key(user), post.id
  #   end
  #   return true
  # end

  # # Removing a like from the post key
  # def self.user_dislikes_post(user, post)
  #   REDIS.multi do
  #     REDIS.srem self.post_key(post), user.id
  #     REDIS.srem self.user_key(user), post.id
  #   end
  #   return true
  # end

  # # Return total likes count per post
  # def self.total_likes_for_post(post)
  #   REDIS.scard self.post_key(post)
  #   return true
  # end

  # # Return all post ids the user liked
  # def self.user_liked_posts(user)
  #   REDIS.scard self.user_key(user)
  #   return true
  # end

  # protected

  # def self.user_key(user)
  #   "users:#{user.id}:liked_posts"
  # end

  # def self.post_key(key)
  #   "posts:#{post.id}:liking_users"
  # end
end