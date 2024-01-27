class TestParticle < Particle
    def init()
        @params["dir"] = [0.0,0.0]
        @params["velocity"] = 0
        @params["steps"] = 117
        @params["time"] = 0
        @params["timer"] = 180
        @texture_path = "fire.png"
        @z = 1
        @params["mouse_coords"] = true

    end

    def texture_effect()
        @zoom = 0.75
        @center = [0, -15]
    end

    def update()
        @angle = 0 if @angle == 360

        @angle = @angle + 2

        move(Vector[Math.cos(to_rad(@angle)) * 3 + Random.rand(10) - 5, Math.sin(to_rad(@angle)) * 3 + Random.rand(10) - 5, 0.01])
    end
end
