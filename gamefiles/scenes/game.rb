
class Game < Scene
    def init()
        @background = image("bg.png")
        b = Bar.new(y:50)
        b.w, b.h = $gb_var[:w], 200
        add_entity(b)
    end
end
