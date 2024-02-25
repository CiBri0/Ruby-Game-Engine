class Button < Entity
    def init()
        add_components(Renderable)
        add_components(Inputable)
        add_components(Hitbox)
        add_components(CameraInfluenced)
        @texture_path = "boss.png"
    end

    def post_init()
        @hitbox = Quad[Point[@texture.x + @pos.x + 20, @texture.y + @pos.y + 20], Point[@texture.x + @pos.x + @texture.w * @texture.zoom - 20 , @texture.y + @pos.y + 20], Point[@texture.x + @pos.x + @texture.w * @texture.zoom - 20, @texture.y + @pos.y + @texture.h * @texture.zoom - 20], Point[@texture.x + @pos.x + 20, @texture.y + @pos.y + @texture.h * @texture.zoom - 20]].to_complexe
    end

    def event_handler()
        pr = Proc.new do |mouse|
            if collide(mouse, @hitbox)
                log("Collide at #{mouse} !")
            end
        end

        on_left_click(pr)
    end
end
