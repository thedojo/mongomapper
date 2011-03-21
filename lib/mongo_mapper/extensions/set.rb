# encoding: UTF-8
require 'set'

module MongoMapper
  module Extensions
    module Set
      def mongo_default
        Set.new
      end

      def to_mongo(value)
        value.to_a
      end

      def from_mongo(value)
        value.nil? ? mongo_default : value.to_set
      end
    end
  end
end

class Set
  extend MongoMapper::Extensions::Set
end