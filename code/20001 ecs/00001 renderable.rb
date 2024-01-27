module Renderable
    def entity_render()
        @texture.render_rect($gb_var[:renderer], 0, 0, @w, @h) if @texture != nil && @params[:visible]
    end
end
