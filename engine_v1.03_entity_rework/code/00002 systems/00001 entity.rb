class Entity
    attr_accessor :id, :texture, :texture_path, :pos, :z, :h, :w, :params, :flip, :zoom, :angle, :cam_focus, :center, :components
    def initialize(pos:Point[0, 0], z: 0, params: {})
        @params = {
            moveable: true,
            visible: true
        }
        @components = []
        @pos = pos
        @z = z
        @zoom = 1
        @angle = 0
        @cam_focus = 1 # false = 1
    end

    def add_components(com)
        @components.append(com)
        extend com
        com.init(self) if com.respond_to?(:init)
    end

    def entity_update()
        update()

        update_coords() if params[:moveable] && params[:visible] && @texture != nil
    end


    def update() #M

    end

    def update_coords()
        @texture.x, @texture.y = @pos.x.floor(), @pos.y.floor()
        @texture.w, @texture.h = @w, @h

        @texture.angle = @angle

        @zoom = @zoom < 0 ? 1.0 : @zoom

        @texture.zoom = @zoom
        @texture.center = @center
    end

    def event_handler() #M

    end

    def self_del()
        $gb_var[:current_scene].del_entity(@id)
    end

    def setup()
        init()
        @texture = image(@texture_path) unless @texture_path == nil
        @h ||= @texture.h unless @texture == nil
        @w ||= @texture.w unless @texture == nil
        texture_effect()
        entity_post_init()
        update_coords() unless @texture == nil
    end

    def move(vec)
        @pos.x = @pos.x + (vec[0] * $gb_var[:dt])
        @pos.y = @pos.y + (vec[1] * $gb_var[:dt])
        @zoom = @zoom + (vec[2] * $gb_var[:dt]) if vec[2] != nil
    end

    def entity_post_init()
        post_init()
    end

    def post_init #M

    end

    def texture_effect #M

    end

    def init() #M

    end

    def <=>(other)
        @z <=> other.z
    end

    def to_s()
        self.class.to_s + " at id " + self.id.to_s
    end
end
