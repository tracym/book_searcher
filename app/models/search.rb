class Search < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  has_many :documents
  after_create_commit :append_documents

  def self.cache(url, cache_policy)
    find_or_initialize_by(url: url).cache(cache_policy) do |search|
      if block_given?
        yield(search)
      end
    end
  end

  def cache(cache_policy)
    if new_record? || updated_at < cache_policy.call
      update(updated_at: Time.zone.now)
      yield(self)
    end
  end

  def append_documents
    DocumentsCreateJob.perform_later(url)
  end
end
