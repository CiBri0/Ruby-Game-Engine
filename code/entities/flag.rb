class Flag < Entity
    def init()
        add_components(Renderable)
        add_components(Hitbox)

        @animation = Animation.new(11, 20)
        @animation.in_anim = true
        @animation.do_loop = false
        @animation.at_end = proc do
            self_del()
        end
        @render_mode = ANIMATION
        @texture_path = "flag.png"
    end
end
