
class Sprite < Entity
    attr_accessor :w, :h
    def init()
        add_components(Renderable)
        add_components(Hitbox)

        @texture_path = "boss.png"
        @pos = Point[50, 50]
    end

    def post_init()
      @hitbox = Complexe[]
    end
end
