module Hitbox
    attr_accessor :hitbox
    def entity_post_init()
        super
        vec = @pos
        vec = vec - camera.pos * @cam_focus if @components.include?(CameraInfluenced)
        x = vec[0]
        y = vec[1]
        @hitbox ||= Complexe[Triangle[Point[x + @pos.x, y + @pos.y], Point[x + @pos.x + @w * @texture.zoom, y + @pos.y], Point[x + @pos.x, y + @pos.y + @texture.h * @texture.zoom]], Triangle[Point[x + @pos.x + @w * @texture.zoom, y + @pos.y + @texture.h * @texture.zoom], Point[x + @pos.x + @w * @texture.zoom, y + @pos.y], Point[x + @pos.x, y + @pos.y + @texture.h * @texture.zoom]]] unless @texture == nil
    end

    def render_hitbox()
        h = @hitbox.move(-camera.pos)
        h.color = [255, 0 ,0]
        h.render()
    end
end

