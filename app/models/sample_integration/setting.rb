module SampleIntegration
  class Setting < ApplicationRecord
    
    belongs_to :service, foreign_key: :sample_integration_service_id, required: true
    validates :channel_id, presence: true, :numericality => { :greater_than_or_equal_to => 0 }, uniqueness: true
    validates :geom, presence: true  
    validates :fault_description, presence: true  
    validates :branded_app_id, presence: true, :numericality => { :greater_than_or_equal_to => 0 }  

  end
end
