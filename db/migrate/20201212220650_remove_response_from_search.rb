class RemoveResponseFromSearch < ActiveRecord::Migration[6.0]
  def change
    remove_column :searches, :response
  end
end
