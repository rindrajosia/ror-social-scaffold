class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
    @friends = friends
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts = []
    friends.each do |friend|
      posts.each do |post|
        if post.user_id.equal?friend.id
          @timeline_posts << post
        end
      end
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def posts
    Post.all.ordered_by_most_recent
  end

  def friends
    friends_confirmed
  end

  def friends_inverse_confirmed
    friendship_array = []
    current_user.friendships.each do |friendship|
      friendship_array << friendship.friend if friendship.status == true
    end
    friendship_array
  end

  def friends_confirmed
    friend = []
    current_user.inverse_friendships.each do |friendship|
      friend << friendship.user if friendship.status == true
    end
    friend
  end
end
