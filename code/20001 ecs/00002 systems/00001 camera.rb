class Camera < Entity
    attr_accessor :speed, :offset, :zoom, :pos, :move
    def init()
        @move = true
        @zoom = 1
        @pos = Point[0, 0]
        @speed = 2.0
        @offset = Vector[0, 0, 0]
    end

    def event_handler()
        @offset = Vector[0, 0, 0]

        press_Z = Proc.new do |x, y|
            @offset = @offset + Vector[0, -@speed, 0]
        end

        press_S = Proc.new do |x, y|
            @offset = @offset + Vector[0, @speed, 0]
        end

        press_Q = Proc.new do |x, y|
            @offset = @offset + Vector[-@speed, 0, 0]
        end

        press_D = Proc.new do |x, y|
            @offset = @offset + Vector[@speed, 0, 0]
        end

        press_A = Proc.new do |y|
            @offset = @offset + Vector[0, 0, -@speed / 20] if y < 0
        end

        press_E = Proc.new do |y|
            @offset = @offset + Vector[0, 0, @speed / 20] if y > 0
        end

        on_press(:z, press_Z)
        on_press(:s, press_S)
        on_press(:d, press_D)
        on_press(:q, press_Q)
        on_wheel(press_A)
        on_wheel(press_E)
    end

    def update()
        move(@offset) if @move == true
    end

    def move(vec)
        @pos.x = @pos.x + (vec[0] * $gb_var[:dt])
        @pos.y = @pos.y + (vec[1] * $gb_var[:dt])
        @zoom = @zoom + (vec[2] * $gb_var[:dt]) unless vec[2] == nil
    end
end

