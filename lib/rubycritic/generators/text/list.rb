require "colorize"

module Rubycritic
  module Generator
    module Text
      class List
        class << self
          TEMPLATE_PATH = File.expand_path("../templates/list.erb", __FILE__)

          def erb_template
            @erb_template ||= ERB.new(File.read(TEMPLATE_PATH), nil, "-")
          end
        end

        RATING_TO_COLOR = {
          "A" => :green,
          "B" => :green,
          "C" => :yellow,
          "D" => :light_red,
          "F" => :red
        }

        def initialize(analysed_module)
          @analysed_module = analysed_module
        end

        def render
          erb_template.result(binding)
        end

        private

        def erb_template
          self.class.erb_template
        end

        def color
          @color ||= RATING_TO_COLOR[@analysed_module.rating.to_s]
        end
      end
    end
  end
end