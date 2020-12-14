class Document < ApplicationRecord
  belongs_to :search

  scope :by_document_data, lambda { |key, value|
    next unless key.present? && value.present?

    value = "%#{value}%"

    clause = 'documents.data ? :key '\
            'AND documents.data->>:key LIKE :value'

    where(clause, key: key, value: value)
  }
end
