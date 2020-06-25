class FriendshipsController < ApplicationController
    before_action :authenticate_user!
    def create
      @friendship = current_user.friendships.build(friend_id: params[:friend_id])
      if @friendship.save
        flash.notice = "Added friend."
        redirect_to users_path
      else
        flash.alert = "Unable to add friend."
        redirect_to users_path
      end
  end
end
