
class Scene
    attr_accessor :entities, :background, :camera, :components
    def initialize()
        @entities = []
        @camera = Camera.new()
        @camera.setup()
        @components = []
    end

    def scene_update()
        @entities.each do |entity|
            entity.entity_update() unless entity == nil
        end

        @camera.update()
        arrange()
        update()
        arrange()
    end

    def arrange()
        e = @entities.compact

        for i in 0..e.length()-1 do
            e[i].id = i
        end

        @entities = e
    end

    def update() #M

    end

    def scene_render()
        case @background
        when Array
            clear(@background[0], @background[1], @background[2])
        when Image
            clear(255, 255, 255)
            @background.render($gb_var[:renderer])
        when Proc
            clear(255, 255, 255)
            @background.call()
        else
            clear(255, 255, 255)
        end

        sort()

        @entities.each do |entity|
            entity.entity_render() if entity.components.include?(Renderable)
        end

        if debug.hitbox_log
            @entities.each do |entity|
                entity.render_hitbox() if entity.components.include?(Hitbox)
            end
        end

        render()
    end

    def sort()
        t = []
        @entities.sort_by!{|obj| obj.z}.each do |i|
            t[i.z] ||= []
            t[i.z].append(i)
        end

        t.each do |i|
            i.sort_by!{|obj| obj.pos.y}
        end


        @entities = t.reduce([], :concat)
        arrange()
    end

    def scene_event_handler()
        @camera.event_handler()

        @entities.each do |entity|
            entity.event_handler() if entity.components.include?(Inputable)
        end
        event_handler()
    end

    def event_handler() #M

    end

    def render() #M

    end

    def add_entity(entity)
=begin old
        for i in 0..@entities.size() - 1 do
            if @entities[i] == nil
                entity.id = i
                entity.setup() if self == $gb_var[:current_scene]
                @entities[i] = entity
                return
            end
        end
        entity.id = @entities.size()
        entity.setup() if self == $gb_var[:current_scene]
        @entities.push(entity)
=end
#=begin new
        entity.id = @entities.size()
        entity.setup() if self == $gb_var[:current_scene]
        @entities.push(entity)
#=end
    end

    def e_show()
        t = []
        @entities.each do |entity|
            t.append(entity.to_s) unless entity == nil
        end

        return t
    end

    def del_entity(id)
        @entities[id].texture.cleanup() if @entities[id].components.include?(Renderable)
        @entities[id] = nil
    end

    def setup()
        init()
        @entities.each do |entity|
            entity.setup() unless entity == nil
        end
    end

    def init() #M

    end

    def self_del()
        @entities.each do |entity|
            del_entity(entity.id) unless entity == nil
        end

        @background.cleanup() if @background.class() == Image

        $gb_var[:bank].each do |img|
            SDL.FreeSurface(img[1])
        end

        $gb_var[:bank] = {}
    end


    def add_components(com)
        @components.append(com)
        extend com
        com.init(self) if com.respond_to?(:init)
    end

    def to_s()
        return self.class
    end
end
