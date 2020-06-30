class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      flash.notice = 'Added friend.'
    else
      flash.alert = 'Unable to add friend.'
    end
    redirect_to users_path
  end

  def update
    @friendship = current_user.inverse_friendships.find(params[:id])
    if @friendship.update(status: true)
      flash[:notice] = 'Confirmed'
      @friend = Friendship.find(params[:id])
      @ft = Friendship.create
      @ft.user_id = current_user.id
      @ft.friend_id = @friend.user_id
      @ft.status = true
      @ft.save
    else
      flash[:notice] = 'Unable to comfirm'
    end
    redirect_to users_path
  end

  def destroy
    @friendship = current_user.inverse_friendships.find(params[:id])

    flash[:notice] = @friendship.destroy ? flash[:notice] = 'Rejected' : 'Unable to reject'

    redirect_to users_path
  end
end
