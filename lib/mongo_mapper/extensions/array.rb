# encoding: UTF-8
module MongoMapper
  module Extensions
    module Array
      def mongo_default
        []
      end

      def to_mongo(value)
        value = value.respond_to?(:lines) ? value.lines : value
        value.to_a
      end

      def from_mongo(value)
        value || store_default
      end
    end
  end
end

class Array
  extend MongoMapper::Extensions::Array
end