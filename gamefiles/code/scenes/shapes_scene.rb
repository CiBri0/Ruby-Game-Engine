
class ShapesScene < Scene
    attr_accessor :points, :close, :cursor, :vectors, :wide, :t
    def init()
        @points = []
        @close = false
        @vectors = []
        @wide = 10
        @t = nil
        @camera.move = false
    end

    def event_handler() #M
        click1 = Proc.new do |mouse|
            mouse = mouse()
            return if @close == true
            if @points.length > 2
                if @points[0][0].between?(mouse[0] - @wide, mouse[0] + @wide) && @points[0][1].between?(mouse[1] - @wide, mouse[1] + @wide)
                    mouse = @points[0]
                    @close = true
                end
            end
            @points.append(mouse)
        end

        on_left_click(click1)

        ctrl_z = Proc.new do
            @points.pop()
            @close = false
        end

        on_single_press([:ctrl, :z], ctrl_z)


        click_3 = Proc.new do |x, y|
            $gb_var[:scene_change].call(Game.new())
        end
        on_middle_click(click_3)

        click_2 = Proc.new do |x, y|
            @points = []
            @close = false
            @vectors = []
            @t = nil
        end
        on_right_click(click_2)
    end

    def update()
        return if @points.length < 2
        if @points[0] == @points[-1]
            #log(@vectors)
            @t = triangulate(@vectors)
        end

        @vectors = []
        for i in 0..@points.length - 2
            v = Vector[@points[i + 1][0], @points[i + 1][1]]
            v.pos = @points[i]
            @vectors.append(v)
        end
    end

    def render()
        @vectors.each do |vec|
            vec.color = [255, 0, 255]
            vec.render()
        end

        @points.each do |point|
            point.color = [255, 0, 0]
            point.render()
        end
        mouse().color = [255, 0, 0]
        mouse().render()

        if @t != nil
            @t.render_fill()
            @t.color = [255, 0, 0]
            @t.render()
        end
    end
end
