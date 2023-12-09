class Scene
    attr_accessor :entities, :background, :priority_queue
    def initialize()
        @entities = []
        @priority_queue = []
    end

    def scene_update()
        @entities.each do |entity|
            entity.entity_update() if entity != nil
        end

        update()
    end

    def update() #M

    end

    def scene_render()
        if @background.class() == Array
            Graphics.clear(@background[0], @background[1], @background[2])
        elsif @background.class() == Image
            Graphics.clear(255, 255, 255)
            @background.render($gb_var[:renderer])
        elsif @background.class() == Proc
            Graphics.clear(255, 255, 255)
            @background.call()
        else
            Graphics.clear(255, 255, 255)
        end

        render()

        @entities.each do |entity|
            entity.entity_render() if entity != nil && !@priority_queue.include?(entity.id)
        end

        for i in 0..@priority_queue.size - 1 do
            @entities[i].entity_render()
        end
    end

    def scene_event_handler(event)
        @entities.each do |entity|
            entity.event_handler(event) if entity != nil
        end
        event_handler(event)
    end

    def event_handler(event) #M

    end

    def render() #M

    end

    def add_entity(entity)
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
    end

    def entity_show()
        @entities.each do |entity|
            puts(entity.class.to_s + " at id " + entity.id.to_s )if entity != nil
        end
    end

    def del_entity(id)
        @entities[id].texture.cleanup()
        @entities[id] = nil if @entities[id] != nil

    end

    def setup()
        init()
        @entities.each do |entity|
            entity.setup() if entity != nil
        end
    end

    def init() #M

    end

    def self_del()
        @entities.each do |entity|
            del_entity(entity.id) if entity != nil
        end

        @background.cleanup if @background.class() == Image

        $gb_var[:bank].each do |img|
            SDL.FreeSurface(img[1])
        end

        $gb_var[:bank] = {}
    end
end
