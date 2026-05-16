# this is basically just a wrapper for ruby2d's built in shape drawing functions

require 'ruby2d'

class Element
    @type = ''
    @x_pos = 0
    @y_pos = 0 # y position is the opposite actually. higher number = lower down on the screen
    @z_index
    @height = 0
    @width = 0
    @size = 0
    @color = 'white'


    def initialize(
        type, 
        x_pos, 
        y_pos,
        z_index=0,
        height=0, 
        width=0, 
        size=0, 
        color='white'
        )
        case type.downcase
        when "square"
            @x_pos = (x_pos - (size / 2)) # this makes it look like the shape is drawn from its center
            @y_pos = (y_pos - (size / 2))
            @z_index = z_index
            @size = size
            @color = color

            Square.new(
                x: @x_pos,
                y: @y_pos,
                z: @z_index,
                size: @size,
                color: @color,
            )
        when "rectangle"
            @x_pos = (x_pos - (width / 2)) # this makes it look like the shape is drawn from its center
            @y_pos = (y_pos - (height / 2))
            @color = color
            @width = width
            @height = height

            Rectangle.new(
                x: @x_pos,
                y: @y_pos,
                color: @color,
                width: @width,
                height: @height
            )
        end # ends case type.downcase
    end # ends initialize()

    def get_attribute(attribute)
        case attribute.downcase
        when "x_pos"
            if @type == "square"
                return @x_pos + (@size / 2)
            else
                return @x_pos + (@width / 2)
            end
        when "y_pos"
            if @type == "square"
                return @y_pos + (@size / 2)
            else
                return @y_pos + (@height / 2)
            end
        when "size"
            return @size
        when "color"
            return @color
        when "width"
            return @width
        when "height"
            return @height
        end
    end
end # ends class