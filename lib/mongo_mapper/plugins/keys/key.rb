# encoding: UTF-8
module MongoMapper
  module Plugins
    module Keys
      class Key
        attr_accessor :name, :type, :options

        def initialize(*args)
          options = args.extract_options!
          @name, @type = args.shift.to_s, args.shift
          self.options = (options || {}).symbolize_keys
        end

        def ==(other)
          @name == other.name && @type == other.type
        end

        def embeddable?
          return false unless type.respond_to?(:embeddable?)
          type.embeddable?
        end

        def can_default_id?
          type && (type == ObjectId || type == BSON::ObjectId || type == String)
        end

        def number?
          type == Integer || type == Float
        end

        def default?
          options.key?(:default) || type.respond_to?(:mongo_default)
        end

        def default
          if options.key?(:default)
            if options[:default].respond_to?(:call)
              options[:default].call
            else
              options[:default].duplicable? ? options[:default].dup : options[:default]
            end
          else
            type.respond_to?(:mongo_default) ? type.mongo_default : nil
          end
        end

        def get(value)
          if options[:typecast].present?
            type.from_mongo(value).map! { |v| typecast_class.from_mongo(v) }
          else
            type.from_mongo(value)
          end
        end

        def set(value)
          type.to_mongo(value).tap do |values|
            if options[:typecast].present?
              values.map! { |v| typecast_class.to_mongo(v) }
            end
          end
        end

        private
          def typecast_class
            @typecast_class ||= options[:typecast].constantize
          end
      end
    end
  end
end
