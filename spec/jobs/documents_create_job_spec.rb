require 'rails_helper'

RSpec.describe DocumentsCreateJob, type: :job do
  describe '#perform_now' do
    let(:url) { 'http://mess.es' }
    let(:search) { Search.create(url: url) }
    let(:docs) { [{ foo: 'bar' }, { baz: 'boom' }] }

    before(:each) do
      search
      allow_any_instance_of(LibrarySearch).to receive(:documents).and_return(docs)
    end

    it 'associates json documents with a search' do
      described_class.perform_now(url) {}
      expect(search.documents).to_not be_empty
    end

    after(:each) do
      Document.delete_all
      Search.delete_all
    end
  end
end
