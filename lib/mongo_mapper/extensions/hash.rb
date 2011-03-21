# encoding: UTF-8
module MongoMapper
  module Extensions
    module Hash
      def mongo_default
        HashWithIndifferentAccess.new
      end

      def from_mongo(value)
        value.nil? ? mongo_default : HashWithIndifferentAccess.new(value)
      end
    end
  end
end

class Hash
  extend MongoMapper::Extensions::Hash
end