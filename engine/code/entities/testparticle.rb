class TestParticle < Particle
    def init()
        @params["dir"] = [0.0,0.0]
        @params["velocity"] = 0
        @params["steps"] = 117
        @params["time"] = 0
        @params["timer"] = 120
        @texture_path = "oin.png"
    end
end
