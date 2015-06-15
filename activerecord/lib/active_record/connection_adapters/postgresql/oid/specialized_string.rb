module ActiveRecord
  module ConnectionAdapters
    module PostgreSQL
      module OID # :nodoc:
        class SpecializedString < Type::String # :nodoc:
          attr_reader :type

          def initialize(type)
            @type = type
          end
        end

        class Circle < Type::String
          def type
            :circle
          end
        end
      end
    end
  end
end
