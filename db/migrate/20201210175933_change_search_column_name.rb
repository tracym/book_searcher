class ChangeSearchColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :searches, :query, :url
  end
end
