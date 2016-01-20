class StaticController < ApplicationController
  def index
    @users = User.all
    @developers = Developer.all
    @links = Link.all
  end
end
