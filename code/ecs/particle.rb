class Particle < Animable
    attr_accessor :time
    def post_init() #M
        super
        @params["anim_loop"] = false
        @params["in_anim"] = true
        #@texture_path = "_.png"
    end

    def update()
        self_del() if @params["time"] == @params["timer"]
    end

end
