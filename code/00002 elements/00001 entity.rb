class Entity
    attr_accessor :id, :pos, :components
    def initialize(pos = Point[0, 0], z = 0)
        @components = []
        @pos = pos
        @z = z
        @cam_focus = 1 # false = 1
    end

    def add_components(com)
        @components.append(com)
        extend com
        com.init(self) if com.respond_to?(:init)
    end

    def entity_update()
        update()
    end


    def update() #M

    end

    def event_handler() #M

    end

    def self_del()
        $gb_var[:current_scene].del_entity(@id)
    end

    def setup()
        init()
        entity_post_init()
    end

    def entity_post_init()
        post_init()
    end

    def post_init() #M

    end

    def texture_effect() #M

    end

    def init() #M

    end

    def <=>(other)
        @z <=> other.z
    end

    def to_s()
        return self.class.to_s + " at id " + self.id.to_s
    end
end
