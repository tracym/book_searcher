class SearchSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :url, :links

  def links
    [
      {
        rel: 'documents',
        href: search_documents_url(object.id)
      }
    ]
  end
end
