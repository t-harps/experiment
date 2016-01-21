class LinksController < ApplicationController

  def create
    if params[:linkable_type]
      @user = User.find(params[:user_id]) 
      @linkable = Developer.find(params[:linkable_id])
      if @user.developer_requests.include?(@linkable)
        @user.approve_developer(@linkable)
        flash[:notice] = "Accepted developer request"
        redirect_to root_path
      elsif params[:toggle]
        @linkable.request_link_with(@user)
        flash[:notice] = "Requested User Approval"
        redirect_to root_path
      else
        @user.request_link_with(@linkable)
        flash[:notice] = "Linked with developer"
        redirect_to root_path
      end
    else
      @user = User.find(params[:user_id]) 
      @linkable = User.find(params[:linkable_id])
      if @user.friend_requests.include?(@linkable) || @user.pending_friends.include?(@linkable)
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


end


