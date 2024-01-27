module CameraInfluenced
    def self.init(en)
        warn("You was not included Hitbox in #{en.to_s}") if !en.components.include?(Hitbox)
        warn("You was not included Renderable in #{en.to_s}") if !en.components.include?(Renderable)
    end

    def entity_update()
        @hitbox = @hitbox.move(-camera().offset)
        super
    end

    def entity_render()
        cam = camera().zoom / 4 * @cam_focus
        @texture.x = @texture.x - camera().pos.x * @cam_focus
        @texture.y = @texture.y - camera().pos.y * @cam_focus
        super
    end
end

