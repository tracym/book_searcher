class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.jsonb :data

      t.timestamps
    end
  end
end
