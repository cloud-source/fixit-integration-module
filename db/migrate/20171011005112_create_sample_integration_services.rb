class CreateSampleIntegrationServices < ActiveRecord::Migration[5.0]
  def change
    create_table :sample_integration_services do |t|
      t.text :url, null: false
      t.text :auth, null: false

      t.timestamps
    end
  end
end
