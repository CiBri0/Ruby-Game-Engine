require_relative "../entity.rb"

class Bar < Entity
    attr_accessor :w, :h
    def init()
        @texture_path = "boss.png"
    end

    def render()
        @texture.render_rect($gb_var[:renderer],0,0,@w,@h)
    end
end
