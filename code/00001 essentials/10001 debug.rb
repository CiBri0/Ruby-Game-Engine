class Debug
    attr_accessor :key_state_log, :hitbox_log, :fps_log
    def initialize()
        @key_state_log = false
        @hitbox_log = true
        @fps_log = false
    end
end
