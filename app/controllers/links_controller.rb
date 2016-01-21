class LinksController < ApplicationController

  def create
    @user = User.find(params[:user_id]) 
    @linkable = User.find(params[:link][:linkable_id]) if params[:link]
    @linkable = User.find(params[:linkable_id]) unless @linkable
    if @user.friend_requests.include?(@linkable)
      Link.accept(@user.id, @linkable.id, 'User')
      flash[:notice] = "Accepted friend request!"
      redirect_to root_path
    else
      Link.link(@user.id, @linkable.id, 'User')
      flash[:notice] = "Sent friend request"
      redirect_to root_path
    end
  end


end


