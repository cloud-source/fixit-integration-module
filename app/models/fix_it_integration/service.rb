module FixItIntegration
  class Service < ApplicationRecord
    validates :url, presence: true  
    validates :auth, presence: true
    has_many :settings
  
  end
end
