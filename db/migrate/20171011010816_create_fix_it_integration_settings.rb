class CreateFixItIntegrationSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :fix_it_integration_settings do |t|
      t.integer :channel_id, null: false
      t.geometry :geom, null: false
      t.text :fault_description, null: false
      t.integer :branded_app_id, null: false
      t.belongs_to :fix_it_integration_service, foreign_key: true, index: { name: "settings service" }

      t.timestamps
    end
  end
end
