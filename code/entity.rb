class Entity
    attr_accessor :id, :texture, :texture_path, :x, :y, :z, :h, :w, :params
    def initialize(x: 0, y: 0, z: 0, params: {})
        @params = {
            moveable: true,
            visible: true,
        }
        @x = x
        @y = y
        @z = z
    end

    def entity_update()
        update()

        update_coords() if params[:moveable] && params[:visible] && @texture_path != nil
    end

    def update() #M

    end

    def update_coords()
        @texture.x = @x.floor()
        @texture.y = @y.floor()
    end

    def event_handler(event) #M

    end

    def self_del()
        $gb_var[:current_scene].del_entity(id)
    end

    def entity_render()
        render() if @texture_path != nil && @params[:visible]
    end

    def render() #M
        @texture.render($gb_var[:renderer])
    end

    def setup()
        init()
        @texture = image(@texture_path)
        @h, @w = @texture.height, @texture.width
        post_init()
        update_coords()
    end

    def post_init #M

    end

    def init() #M

    end

    def on_click(event)

    end

    def <=>(other)
        @z <=> other.z
    end
end
