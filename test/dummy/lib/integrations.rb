# Stubbed Integration module.
# This is here just a alternative implementation to mimic Thundermaps Integration module.
module Integrations

  def self.create_channel(*args)
    @channels ||= []
    @last_channel_id ||= 0
    channel = OpenStruct.new(id: (@last_channel_id += 1), created_at: Time.current)
    @channels.push channel
    channel
  end

  def self.update_user(user_id, data)
    @users ||= {}
    @last_user_id ||= 0
    user = @users[user_id] ||= OpenStruct.new(id: user_id, created_at: Time.current)
    data.each do |k, v|
      user[k] = v
    end
    user
  end

  def self.method_missing(name, *args, &block)
    msg = "Fake call. Not Yet Implemented: Integrations.#{name}(#{args.inspect}) #{!!block && "{}"}"
    puts msg
    Rails.logger.warn msg
  end
end
