RENDER = 0
ANIMATION = 1

module Renderable
    attr_accessor :texture, :render_mode, :texture, :h, :w, :z, :flip, :zoom, :angle, :center
    attr_accessor :time, :animation

    #a acces a @components

    def entity_post_init()
        error("No texture given for #{self.to_s}") if @texture_path == nil

        @texture = image(@texture_path)
        @render_mode ||= RENDER
        @zoom = 1
        @angle = 0

        if @render_mode == RENDER
            @h ||= @texture.h
            @w ||= @texture.w
        else
            @h ||= @texture.h
            @w ||= @texture.w / @animation.steps
            @time = 0
        end

        texture_effect()
        super
    end


    def entity_update()
        if @render_mode == ANIMATION
            #log(@time)
            if @animation.in_anim
                @time = @time + 1 * $gb_var[:dt]

                if @time >= @animation.max_frame
                    @time = 0.0
                    @animation.in_anim = @animation.do_loop
                    @animation.at_end.call()             #self_del()
                end
            end
        end

        super
    end


    def entity_render()
        vec = @pos
        vec = vec - camera.pos * @cam_focus if @components.include?(CameraInfluenced)

        @texture.x, @texture.y = vec[0], vec[1]
        @texture.w, @texture.h = @w, @h

        @texture.angle = @angle
        @texture.zoom = @zoom
        @texture.center = @center

        if @render_mode == RENDER
            @texture.render_rect($gb_var[:renderer], 0, 0, @w, @h) if render_mode == RENDER
            return
        else
            @texture.render_rect($gb_var[:renderer], @w.floor() * state(), 0,
                                                     @w.floor(), @h)
        end
    end

    def state()
        return (@time / (@animation.max_frame).to_f * @animation.steps).floor()
    end
end


class Animation
    attr_accessor :steps, :in_anim, :at_end, :max_frame, :do_loop
    def initialize(steps, max_frame = 60, do_loop = false, at_end = proc{})
        @steps = steps
        @at_end = at_end
        @max_frame = max_frame
        @do_loop = do_loop
        @in_anim = true
    end
end
