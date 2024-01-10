class Entity
    attr_accessor :id, :texture, :texture_path, :x, :y, :z, :h, :w, :params, :flip, :zoom
    def initialize(x: 0, y: 0, z: 0, params: {})
        @params = {
            moveable: true,
            visible: true,
            mouse_coords: false,
        }
        @x = x
        @y = y
        @z = z
        @zoom = 1
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

    def event_handler() #M

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
        @h, @w = @texture.h, @texture.w
        texture_effect()
        post_init()
        update_coords()
    end

    def post_init #M

    end

    def texture_effect #M

    end

    def init() #M

    end

    def on_click(action)
        pr = Proc.new do |x,y|
=begin
            n = 50
            if quad_in(
                [[event[:button][:x] - n, event[:button][:y] - n],
                    [event[:button][:x] - n, event[:button][:y] + n],
                    [event[:button][:x] + n, event[:button][:y] + n],
                    [event[:button][:x] + n, event[:button][:y] - n]],
                    [@x, @y, @x + @w, @y + @h])
=end
            if point_in([x,y], [@x, @y, @x + @w, @y + @h])
                action.call(x, y)
            end
        end
        $gb_var[:event_handler].on_click(1, pr)
    end

    def <=>(other)
        @z <=> other.z
    end
end
