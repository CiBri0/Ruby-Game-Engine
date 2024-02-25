module CameraInfluenced
    attr_accessor :cam_focus
    def self.init(en)
        entity_dependencies(en, [Renderable])
    end

    def entity_post_init()
        @cam_focus = 1
        super
    end
end

