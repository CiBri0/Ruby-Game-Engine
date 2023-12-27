class TestParticle < Particle
    attr_accessor :a
    def init()
        @params["dir"] = [0.0,0.0]
        @params["velocity"] = 0
        @params["steps"] = 117
        @params["time"] = 0
        @params["timer"] = 180
        @texture_path = "fire.png"
        @z = 1
        @params["mouse_coords"] = true

        @a = 0
    end

    def texture_effect()
        @texture.zoom = 2
    end

    def update()
        @a = 0 if @a == 360

        @a = @a + 2
        @texture.angle = @a
    end

    def render() #M
        @texture.render($gb_var[:renderer])
    end
end
