class TestParticle < Entity
    def init()
        add_components(Renderable)
        add_components(CameraInfluenced)
        add_components(Moveable)

        @animation = Animation.new(117, 180)
        @animation.in_anim = true
        @animation.at_end = proc do
            self_del()
        end
        @render_mode = ANIMATION
        @texture_path = "fire.png"
    end

    def texture_effect()
        @zoom = 0.75
        @center = [0, -15]
    end

    def update()
        s = 7

        @angle = 0 if @angle >= 360

        @angle = @angle + 2 * $gb_var[:dt]
        @zoom = @zoom + 0.01 * $gb_var[:dt]

        move(Vector[Math.cos(to_rad(@angle)) * s + Random.rand(10) - 5, Math.sin(to_rad(@angle)) * s + Random.rand(10) - 5])
    end
end


class Smoke < Entity
    def init()
        add_components(Renderable)
        add_components(CameraInfluenced)
        add_components(Moveable)

        @animation = Animation.new(9, 30)
        @animation.in_anim = true
        @animation.at_end = proc do
            self_del()
        end
        @render_mode = ANIMATION
        @texture_path = "smoke.png"
    end

    def texture_effect()
        @zoom = 2
        @center = [0, -15]
    end
end

class Water < Entity
    def init()
        add_components(Renderable)
        add_components(CameraInfluenced)
        add_components(Moveable)
        frame = 60

        @animation = Animation.new(21, frame)
        @animation.in_anim = true
        @animation.at_end = proc do
            @texture = image("water2.png")
            @animation.steps = 16
            @animation.max_frame = (frame * 21.0 / 16.0).floor()
        end
        @animation.do_loop = true
        @render_mode = ANIMATION
        @texture_path = "water.png"
    end

    def texture_effect()
        @zoom = 1.5
        @center = true
    end

    def update()
        dir = mouse() - @pos

        speed = hyp(dir) / 20 * $gb_var[:dt]
        dir = Vector[dir[0], dir[1]]
        dir = dir.normalize() * speed if dir != Vector[0, 0]

        @angle = to_deg(-Math.atan2(-dir[1], dir.dot(Vector[1, 0])))
        move(dir)
    end
end

