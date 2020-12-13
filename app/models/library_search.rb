require 'uri'
require 'yajl/http_stream'

class LibrarySearch
  BASE_URL = 'http://openlibrary.org/'.freeze
  CACHE_POLICY = -> { 30.days.ago }

  attr_reader :total, :position

  def initialize(query: nil, url: nil)
    @query = query
    @url = url
  end

  def url
    @url ||= BASE_URL + 'search.json?' + {
      q: @query
    }.to_query
    return @url if @query || @url

    nil
  end

  def documents
    Enumerator.new do |yielder|
      page = 1

      loop do
        break unless url

        parsed_uri = URI.parse("#{url}&page=#{page}")
        Yajl::HttpStream.get(parsed_uri) do |docs|
          @total = docs['num_found']
          @position = docs['start']
          docs['docs'].each do |row|
            yielder << row
          end
        end

        raise StopIteration if @position > @total

        page += 1
      end
    end.lazy
  end
end
