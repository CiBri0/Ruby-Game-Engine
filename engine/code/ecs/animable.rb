class Animable < Entity
    attr_accessor :time
    def init() #M
        #@texture_path = "_.png"
    end

    def post_init() #M
        @params["anim_loop"] = true if @params["anim_loop"] == nil
        @params["anim_end"] = false if @params["anim_end"] == nil
        @params["in_anim"] = false if @params["in_anim"] == nil
        @params["anim_id"] = 0 if @params["anim_id"] == nil
        @params["anims"] = [{}] if @params["anim_id"] == nil
        @params["dir"] = [0.0,0.0] if @params["dir"] == nil
        @params["velocity"] = 0 if @params["steps"] == nil
        @params["steps"] = 0 if @params["steps"] == nil
        @params["time"] = 0.0
        @params["timer"] = 0.0 if @params["timer"] == nil
        @params["time"] = @params["time"].to_f
    end

    def entity_update()
        @params["anim_end"] = false
        if @params["in_anim"] == true
            @params["time"] = @params["time"] + 1
            if @params["time"] == @params["timer"]
                if @params["anim_loop"] == false
                    @params["in_anim"], @params["anim_end"] = false, true
                else
                    @params["time"] = 0.0
                end
            end
        end
        update()

        update_coords() if params[:moveable] && params[:visible] && @texture_path != nil
    end

    def entity_render()
        if @params["in_anim"] == true && @texture_path != nil && @params[:visible]
            @texture.render_rect($gb_var[:renderer], (@w / @params["steps"]).floor() * state(), 0,
                                                     @w / @params["steps"], @h)
            return
        end
        render() if @texture_path != nil && @params[:visible]
    end

    def state()
        return (@params["time"] / (@params["timer"] + 1) * @params["steps"]).floor()
    end

end
