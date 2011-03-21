# encoding: UTF-8
module MongoMapper
  module Plugins
    module Rails
      extend ActiveSupport::Concern

      module InstanceMethods
        def to_param
          id.to_s if persisted?
        end

        def to_model
          self
        end

        def to_key
          [id] if persisted?
        end

        def new_record?
          new?
        end
      end

      module ClassMethods
        def has_one(*args)
          one(*args)
        end

        def has_many(*args)
          many(*args)
        end

        def column_names
          keys.keys
        end

        def human_name
          self.name.demodulize.titleize
        end
      end
    end
  end
end