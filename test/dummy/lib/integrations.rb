# Stubbed Integration module.
# This is here just a alternative implementation to mimic Thundermaps Integration module.
module Integrations

  mattr_accessor :subscriptions
  @@subscriptions = {}

  mattr_accessor :repositories
  @@repositories = {}

  def self.subscribe(event, &action)
    subscriptions[event] = (Array(subscriptions[event])) << action
  end

  def self.register(repository_id, entity_id, &block)
    repository = repositories[repository_id] ||= {}
    repository[entity_id] = block
  end

  def self.create_channel(*args)
    @channels ||= []
    @last_channel_id ||= 0
    channel = OpenStruct.new(id: (@last_channel_id += 1), created_at: Time.current)
    @channels.push channel
    channel
  end

  def create_user(data)
    @users ||= []
    @last_user_id ||= 0
    user = OpenStruct.new(id: (@last_user_id += 1), created_at: Time.current)
    data.each do |k, v|
      user[k] = v
    end
    @users.push user
    user
  end

  def self.update_user(user_id, data)
    @users ||= []
    @last_user_id ||= 0

    not_found_policy = -> { raise ActiveRecord::RecordNotFound, "Couldn't find User with 'id'=#{user_id}"}
    user = @user.find(not_found_policy) do |u|
      u.id == user_id
    end

    data.each do |k, v|
      user[k] = v
    end
    user
  end

  def self.update_channel_users_roles(channel_id, role_set)
    # role_set = [{user_id: 1, role_name: :operator}, ...]
    not_found_policy = -> { raise ActiveRecord::RecordNotFound, "Couldn't find Channel with 'id'=#{channel_id}"}
    channel = @channels.find(not_found_policy) do |c|
      c.id == channel_id
    end
    @roles.keep_if {|existing_role| role_set.find{|role| existing_role.channel_id == channel.id && existing_role.user_id == role[:user_id]}}
    role_set.each do |role|
      set_channel_user_role(channel.id, role[:user_id], role[:role_name])
    end
  end

  private

  def self.set_channel_user_role(channel_id, user_id, role_name)
    @roles ||= []
    role = @roles.find{|r| r.channel_id == channel_id && r.user_id == user_id }
    role ||= OpenStruct.new(channel_id: channel_id, user_id: user_id).tap{|r| @roles.push r }
    role.role_name = role_name
    role
  end

  def self.method_missing(name, *args, &block)
    msg = "Fake call. Not Yet Implemented: Integrations.#{name}(#{args.inspect}) #{!!block && "{}"}"
    puts msg
    Rails.logger.warn msg
  end
end
