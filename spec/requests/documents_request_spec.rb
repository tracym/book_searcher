require 'rails_helper'

RSpec.describe 'Search Documents Retrieval', type: :request do
  describe 'GET #documents' do
    let(:body) { { query: 'test' } }
    let(:search) { Search.create(url: 'http://search.com?q=hi')}
    let(:docs) do
      [
        { key: 'foo', title: 'Foo: bar', subject: ['Foo', 'bar', 'baz'] },
        { key: 'good', title: 'Good Title', author_name: ['Foo', 'Bar', 'et al'] },
        { key: 'key', title: 'Another Title', author_name: ['Bar'] }
      ]
    end

    before(:each) do
      id = search.id
      docs.each do |doc|
        search.documents << Document.new(data: doc)
      end
      get "/library/search/#{id}/documents", params: body
    end

    context 'Paging' do
      let(:page_size) { 1 }
      let(:body) { { page_size: page_size } }
      it 'returns a 200 status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the amount of data in page size' do
        json = JSON.parse(response.body)
        expect(json['data'].count).to eq(page_size)
      end
    end

    context 'Sorting' do
      let(:sort_key) { 'author_name' }
      let(:sort_dir) { 'asc' }

      let(:body) { { sort_key: sort_key, sort_dir: sort_dir } }
      it 'returns a 200 status' do
        expect(response).to have_http_status(:success)
      end

      describe 'ascending order' do
        let(:sort_dir) { 'asc' }

        it 'sorts correctly' do
          data = JSON.parse(response.body)['data']
          author = data[0]['attributes']['data']['author-name']
          expect(author).to eq(['Bar'])
        end
      end

      describe 'descending order' do
        let(:sort_dir) { 'desc' }

        it 'sorts correctly' do
          data = JSON.parse(response.body)['data']
          author = data[0]['attributes']['data']['author-name']
          expect(author).to be_nil
        end
      end
    end

    context 'Filtering' do
      let(:filter_key) { 'author_name' }
      let(:filter_value) { 'et al' }

      let(:body) { { filter_key: filter_key, filter_value: filter_value } }
      it 'returns a 200 status' do
        expect(response).to have_http_status(:success)
      end

      it 'can filter by a key' do
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(1)
      end
    end

    after(:each) do
      Document.delete_all
      Search.delete_all
    end
  end
end
