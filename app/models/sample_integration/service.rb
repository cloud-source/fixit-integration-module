module SampleIntegration
  class Service < ApplicationRecord
    validates :url, presence: true  
    validates :auth, presence: true
  
  end
end
