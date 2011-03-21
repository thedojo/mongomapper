# encoding: UTF-8
module MongoMapper
  module Extensions
    module Float
      def to_mongo(value)
        value.nil? ? nil : value.to_f
      end

      def from_mongo(value)
        to_mongo(value)
      end
    end
  end
end

class Float
  extend MongoMapper::Extensions::Float
end