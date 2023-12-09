require_relative "../entity.rb"

class Button < Entity

    def init()
        @texture_path = "boss.png"
    end

    def render()
        @texture.render($gb_var[:renderer])
    end
end
