module AttributeBoolean

  VERSION = "1.0.1"

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
        if options.has_key?(:false_values)
          options[:false_values]
        elsif options.has_key?("false_values")
          options["false_values"]
        end

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

        alias_method "#{ name }", "#{ name }?"

        define_method("#{ name }=") do |value|
          is_true =
            if value == nil
              default_value
            elsif false_values
              ! false_values.include?(value.to_s)
            else
              ! AttributeBoolean.false_values.include?(value.to_s)
            end

          instance_variable_set(ivar, is_true)
        end
      end
    end
  end

  class << self
    def included(base)
      base.send(:extend, ClassMethods)
    end

    def reset_false_values!
      @false_values = [ false, 0, '0', 'f', 'F', 'false', 'FALSE', 'off', 'OFF', 'n', 'N', 'no', 'NO' ]
    end

    def false_values
      @false_values or reset_false_values!
    end

    def false_values=(false_values)
      @false_values = false_values
    end
  end

  # Mix AttributeBoolean into ActiveRecord::Base if Rails is loaded.
  if defined? Rails::Railtie
    class Railtie < Rails::Railtie
      initializer "attribute_boolean.initialize" do
        ActiveSupport.on_load(:active_record) do
          ActiveRecord::Base.send(:include, AttributeBoolean)
        end
      end
    end
  end

end
