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
        @params["timer"] = 0.0 if @params["timer"] == nil
        @params["time"] = 0.0
        @params["timer"] = @params["timer"].to_f
        @w = (@texture.w.to_f / @params["steps"])
    end

    def entity_update()
        @params["anim_end"] = false
        if @params["in_anim"] == true
            @params["time"] = @params["time"] + 1 * $gb_var[:dt]
            if @params["time"] >= @params["timer"]
                if @params["anim_loop"] == false
                    @params["in_anim"], @params["anim_end"] = false, true
                    self_del()
                else
                    @params["time"] = 0.0
                end
            end
        end
        update()

        update_coords() if params[:moveable] && params[:visible] && @texture_path != nil
    end

    def entity_render()
        cam = camera().zoom / 4 * @cam_focus
        @texture.x = @texture.x - camera().x * @cam_focus
        @texture.y = @texture.y - camera().y * @cam_focus

        @hitbox = Complexe[Triangle[Point[@texture.x, @texture.y], Point[@texture.x + @texture.w * @texture.zoom, @texture.y], Point[@texture.x, @texture.y + @texture.h * @texture.zoom]], Triangle[Point[@texture.x + @texture.w * @texture.zoom, @texture.y + @texture.h * @texture.zoom], Point[@texture.x + @texture.w * @texture.zoom, @texture.y], Point[@texture.x, @texture.y + @texture.h * @texture.zoom]]] unless @texture == nil
        @hitbox = turn_complexe(@hitbox, @angle)

        if @params["in_anim"] == true && @texture_path != nil && @params[:visible]
            @texture.render_rect($gb_var[:renderer], @w.floor() * state(), 0,
                                                     @w.floor(), @h)
            return
        end
    end

    def state()
        return (@params["time"] / (@params["timer"] + 1) * @params["steps"]).floor()
    end
end
