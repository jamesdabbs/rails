module ActiveRecord
  Circle = Struct.new(:x, :y, :r)

  module ConnectionAdapters
    module PostgreSQL
      module OID # :nodoc:
        class Rails51Circle < Type::Value # :nodoc:
          include Type::Helpers::Mutable

          def type
            :circle
          end

          def cast(value)
            case value
            when ::String
              # TODO: Preferred regex style? Something readable, maybe?
              if value =~ /<\(([^,]+),([^)]+)\),([^>]+)>/
                build_circle($1, $2, $3)
              else
                # TODO: ???
              end
            else
              value
            end
          end

          def serialize(value)
            if value.is_a?(ActiveRecord::Circle)
              "<(#{number_for_point(value.x)},#{number_for_point(value.y)}),#{number_for_point(value.r)}>"
            else
              super
            end
          end

          private

          def number_for_point(number)
            number.to_s.gsub(/\.0$/, '')
          end

          def build_circle(x, y, r)
            ActiveRecord::Circle.new(Float(x), Float(y), Float(r))
          end
        end
      end
    end
  end
end
