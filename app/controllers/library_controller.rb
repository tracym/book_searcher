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

  def documents
    search = Search.find(params[:id])

    docs = paged_documents(sorted_documents(filtered_documents(search)))
    render json: docs
  end

  private

  def filtered_documents(search)
    search.documents.by_document_data(filter_key, filter_value)
  end

  def sorted_documents(documents)
    return documents unless sort_key && sort_dir

    clause = "data->'#{sort_key}' #{sort_dir}"
    documents.order(Arel.sql(clause))
  end

  def paged_documents(documents)
    documents.page(page).per(per)
  end

  def page
    params[:page_number] || 1
  end

  def per
    params[:page_size] || 15
  end

  def filter_key
    params[:filter_key]
  end

  def filter_value
    params[:filter_value]
  end

  def sort_key
    params[:sort_key]
  end

  def sort_dir
    params[:sort_dir]
  end
end
