# this is basically just a wrapper for ruby2d's built in shape drawing functions

require 'ruby2d'

class Element
    def initialize(type, x_pos, y_pos, size, color='white', width=0, height=0)
        case type.downcase
        when "square"
            Square.new(
                x: x_pos,
                y: y_pos,
                size: size,
                color: color,
            )
        when "rectangle"
            Rectangle.new(
                x: x_pos,
                y: y_pos,
                size: size,
                color: color,
                width: width,
                height: height
            )
        end # ends case type.downcase
    end # ends initialize()
end # ends class