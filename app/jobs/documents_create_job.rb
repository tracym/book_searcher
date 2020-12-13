class DocumentsCreateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    url = args[0]
    search = Search.find_by_url(url)
    lib_search = LibrarySearch.new(url: url)
    begin
      lib_search.documents.each do |doc|
        search.documents << Document.new(data: doc)
      end
    rescue StopIteration => e
      puts e
    end
  end
end
