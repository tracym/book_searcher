Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/library/search', to: 'library#search'
  get '/library/search/:id/documents', to: 'library#documents', as: 'search_documents'
end
