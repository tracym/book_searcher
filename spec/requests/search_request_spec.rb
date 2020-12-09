require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  it 'returns successfully from the search' do
    get '/search'
    expect(response.body).to eq('hello, world')
  end
end
