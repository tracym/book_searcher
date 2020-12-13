class AddResponseToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :response, :text
  end
end
