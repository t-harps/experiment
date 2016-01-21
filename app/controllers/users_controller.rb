class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @search = UserSearch.new(search_params)
    @things = search_params.present? ? @search.results : User.all
  end

  # GET /users/typeahead/:query
  def typeahead
    @search  = ThingSearch.new(typeahead: params[:query])
    render json: @search.results
  end

  private

  def search_params
    params[:thing_search] || {}
  end

end