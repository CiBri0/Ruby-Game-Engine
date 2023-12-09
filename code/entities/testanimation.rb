class TestAnimation < Animable
    def init()
        @params["dir"] = [0.0,0.0]
        @params["velocity"] = 0
        @params["steps"] = 10
        @params["time"] = 0
        @params["timer"] = 10 if @params["timer"] == nil
        @texture_path = "score.png"
        @params["in_anim"] = true
    end
end
