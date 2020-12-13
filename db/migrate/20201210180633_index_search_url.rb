class IndexSearchUrl < ActiveRecord::Migration[6.0]
  def change
    add_index :searches, :url, unique: true
  end
end
