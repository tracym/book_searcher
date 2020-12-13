require 'rails_helper'

RSpec.describe Search, type: :model do
  let(:url) { 'http://cool.com' }

  it 'is not valid without a url' do
    search = Search.new(url: nil)
    expect(search).to_not be_valid
  end

  it 'is valid with a url' do
    search = Search.new(url: url)
    expect(search).to be_valid
  end

  describe 'caching' do
    context 'existing urls' do
      let(:existing) { Search.create(url: url)}
      it 'does not return a record' do
        record = existing
        policy = 1.day.ago
        expect(Search.cache(record, policy)).to be_nil
      end
    end
  end
end
