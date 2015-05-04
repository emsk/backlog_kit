require 'active_support/core_ext/hash/keys'

class Hash
  def camelize_keys!
    deep_transform_keys! do |key|
      key.to_s
        .split(/(_*\d+_*)/)
        .reject(&:empty?)
        .map { |key| key.camelize(:lower) }
        .join('_')
        .to_sym
    end

    self
  end
end
