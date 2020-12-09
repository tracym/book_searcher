class SearchController < ApplicationController
  def search
    render json: Search.first.query
  end
end
