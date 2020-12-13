require 'rails_helper'

RSpec.describe 'Library Searches', type: :request do
  describe 'POST #search' do
    let(:body) { { query: 'test' } }
    let(:url) { "http://search.com?q=#{body[:query]}" }

    before(:each) do
      allow_any_instance_of(Search).to receive(:append_documents).and_return([])
      post '/library/search', params: body
    end

    context 'existing searches' do
      before(:each) do
        Search.create(url: url)
        allow_any_instance_of(LibrarySearch).to receive(:url).and_return(url)
      end

      it 'returns a 200 status' do
        expect(response).to have_http_status(:success)
      end

      after(:each) do
        Search.delete_all
      end
    end

    context 'new searches' do
      before(:each) do
        allow_any_instance_of(LibrarySearch).to receive(:url).and_return(url)
      end

      it 'returns a 201 status' do
        expect(response).to have_http_status(:created)
      end

      after(:each) do
        Search.delete_all
      end
    end
  end
end
