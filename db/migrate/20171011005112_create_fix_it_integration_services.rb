class CreateFixItIntegrationServices < ActiveRecord::Migration[5.0]
  def change
    create_table :fix_it_integration_services do |t|
      t.text :url, null: false
      t.text :auth, null: false

      t.timestamps
    end
  end
end
