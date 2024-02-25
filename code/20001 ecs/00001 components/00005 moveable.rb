module Moveable
    def move(vec)
        @pos.x = @pos.x + (vec[0] * $gb_var[:dt])
        @pos.y = @pos.y + (vec[1] * $gb_var[:dt])
        @zoom = @zoom + (vec[2] * $gb_var[:dt]) unless vec[2] == nil
    end
end
