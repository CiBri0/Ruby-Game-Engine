module Hitbox
    attr_accessor :hitbox
    def entity_post_init()
        @hitbox = Complexe[Triangle[Point[@texture.x + @pos.x, @texture.y + @pos.y], Point[@texture.x + @pos.x + @texture.w * @texture.zoom, @texture.y + @pos.y], Point[@texture.x + @pos.x, @texture.y + @pos.y + @texture.h * @texture.zoom]], Triangle[Point[@texture.x + @pos.x + @texture.w * @texture.zoom, @texture.y + @pos.y + @texture.h * @texture.zoom], Point[@texture.x + @pos.x + @texture.w * @texture.zoom, @texture.y + @pos.y], Point[@texture.x + @pos.x, @texture.y + @pos.y + @texture.h * @texture.zoom]]] unless @texture == nil
        super
    end
end

