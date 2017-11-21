module FixItIntegration
  class Setting < ApplicationRecord
    require 'base64'
    
    belongs_to :service, foreign_key: :fix_it_integration_service_id, required: true
    validates :channel_id, presence: true, :numericality => { :greater_than_or_equal_to => 0 }, uniqueness: true
    validates :geom, presence: true  
    validates :fault_description, presence: true  
    validates :branded_app_id, presence: true, :numericality => { :greater_than_or_equal_to => 0 }  

    def send_report(report)

      headers = { 
        "Content-Type" => "application/json",
        "Authorization" => "Basic #{service.auth}"
      }

      payload =  {
        "fixitRequest" => {
          "faultType" => "generic",
          "faultDesc" => fault_description,
          "sourceType" => "ThunderMaps",
          "sourceDeviceType" => BrandedApp.find(branded_app_id).name,
          "sourceOs" => "ThunderMaps",
          "locAddress" => (report.address ? report.address : "See attached Link"),
          "googleLink" => "#{BrandedApp.find(branded_app_id).hydra_url}/#!/reports/#{report.id}/",
          "locLatitude" => report.latitude,
          "locLongitude" => report.longitude,
          "contactFirstName" => ( report.user.first_name ? report.user.first_name : "Not Provided"),
          "contactLastName" => (report.user.last_name ? report.user.last_name : "Not Provided"),
          "contactEmail" => report.user.email,
          "contactPhone" => ( report.user.contact_number ? report.user.contact_number : "Not Provided"),
          "contactOptOut":0,                        
        }
      }
      count = 1
      report.report_images.each do |ri| 
        payload["fixitRequest"]["photo#{count}"] = encode_image(ri)
        break if count > 3
        count = count +1
      end

      if Rails.env.production?
        result = HTTParty.post(service.url, body: payload.to_json, headers: headers) 
        logger.info("FixIt API Push Result Code: #{result.code}")
      else
        logger.info("Would have sent FixIt Paylod: #{payload.to_json}")
      end
    end

   def encode_image(report_image)
    image = Magick::Image.from_blob(open(report_image.url).read).first

    width=500
    height=500

    resized = image.resize_to_fit(width, height)     # will maintain aspect ratio, so one of the resized dimensions may be less than the specified dimensions
    resized.background_color = "#FFFFFF"             # without a default, background color will vary based on the border of your original image
    x = (resized.columns - width) / 2                # calculate necessary translation to center image on background
    y = (resized.rows - height) / 2
    resized = resized.extent(width, height, x, y)    # 'extent' fills out the resized image if necessary, with the background color, to match the full requested dimensions. the x and y parameters calculated in the previous step center the image on the background.
    Base64.encode64(resized.to_blob).gsub(/\n/, "") 
    end
  end
end
