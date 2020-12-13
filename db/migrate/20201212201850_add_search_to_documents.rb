class AddSearchToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_reference :documents, :search, null: false, foreign_key: true
  end
end
