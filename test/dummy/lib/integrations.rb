# Stubbed Integration module.
# This is here just a alternative implementation to mimic Thundermaps Integration module.
module Integrations
  def self.method_missing(name, *args, &block)
    msg = "Fake call. Not Yet Implemented: Integrations.#{name}(#{args.inspect}) #{!!block && "{}"}"
    puts msg
    Rails.logger.warn msg
  end
end
