class Button < Entity
    def init()
        add_components(Renderable)
        add_components(Controllable)
        add_components(Hitbox)
        add_components(CameraInfluenced)
        @texture_path = "boss.png"
    end

    def event_handler()
        pr = Proc.new do |mouse|
            if collide(mouse, @hitbox)
                p mouse
            end
        end

        on_right_click(pr)
    end
end
