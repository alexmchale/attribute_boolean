require "attribute_boolean/version"

module AttributeBoolean

  module ClassMethods
    def attr_boolean(*args)
      options =
        if args.last.kind_of?(Hash)
          args.pop
        else
          {}
        end

      default_value =
        if options.has_key?(:default)
          !! options[:default]
        elsif options.has_key?("default")
          !! options["default"]
        else
          false
        end

      false_values =
        [ false, 0, '0', 'f', 'F', 'false', 'FALSE', 'off', 'OFF', 'n', 'N', 'no', 'NO' ]

      args.each do |name|
        ivar = "@#{ name }"

        define_method("#{ name }?") do
          value = instance_variable_get(ivar)

          if value == nil
            default_value
          else
            !! value
          end
        end

        define_method("#{ name }=") do |value|
          is_true =
            if value == nil
              default_value
            else
              ! false_values.include?(value.to_s)
            end

          instance_variable_set(ivar, is_true)
        end
      end
    end
  end

  def self.included(base)
    base.send(:extend, ClassMethods)
  end

end
