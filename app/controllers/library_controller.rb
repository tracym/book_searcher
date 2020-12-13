class LibraryController < ApplicationController

  def search
    url = LibrarySearch.new(query: params[:query]).url
    search = Search.cache(url, LibrarySearch::CACHE_POLICY) do |rec|
      rec
    end

    status = search ? :created : :ok
    search ||= Search.find_by_url(url)

    render json: search, status: status
  end
end
