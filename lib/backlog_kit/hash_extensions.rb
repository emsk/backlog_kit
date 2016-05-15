require 'active_support/core_ext/hash/keys'

class Hash
  # Camelize all keys of the hash
  #
  # @return [Hash] The hash with camelized keys
  def camelize_keys!
    deep_transform_keys! do |key|
      key.to_s
        .split(/(_*\d+_*)/)
        .reject(&:empty?)
        .map { |k| k.camelize(:lower) }
        .join('_')
        .to_sym
    end

    self
  end
end
