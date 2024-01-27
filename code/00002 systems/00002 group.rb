class Group < Entity
    attr_accessor :id, :entities, :x, :y, :z
    def initialize(x: 0, y: 0, z: 0, params: {})
        @params = {
            moveable: true,
            visible: true,
            mouse_coords: false,
        }
        @x = x
        @y = y
        @z = z
        @entities = []
    end

    def entity_update()
        @entities.each do |entity|
            entity.entity_update()
        end

        update_coords() if params[:moveable] && params[:visible] && @texture_path != nil
    end

    def self_del()
        @entities.each do |entity|
            entity.texture.cleanup()
            entity = nil
        end
        $gb_var[:current_scene].del_entity(id)
    end

    def entity_render()
        sort()

        if @params[:visible]
            @entities.each do |entity|
                entity.entity_render()
            end
        end
    end

    def sort()
        t = []
        @entities.sort_by!{|obj| obj.z}
        for e in @entities do
            t[e.z] = [] if t[e.z] == nil
            t[e.z].append(e)
        end

        for i in t do
            i.sort_by!{|obj| 1/obj.y}
        end
        #@entities.max_by(&:z)
    end

    def setup()

        init()
        post_init()

        @entities.each do |e|
            e.x = @x
            e.y = @y
            e.z = @z
        end

        @entities.each do |entity|
            entity.setup() if entity != nil
        end
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
end

