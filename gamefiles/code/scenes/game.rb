
class Game < Scene
    attr_accessor :form, :n
    def init()
        @form = []
        @n = 0
        @form.append(Triangle[Point[200, 100], Point[140, 160], Point[120, 80]])
        @form.append(Triangle[Point[80, 40], Point[160, 80], Point[80, 100]])
        @form.append(Quad[Point[180, 140], Point[280, 140], Point[280, 240], Point[180, 240]].to_complexe)
        @form.append(Complexe[Triangle[Point[110, 40], Point[180, 70], Point[120, 110]],
        Triangle[Point[180, 150], Point[180, 70], Point[120, 110]],
        Triangle[Point[180, 150], Point[80, 180], Point[120, 110]],
        Triangle[Point[40, 100], Point[80, 180], Point[120, 110]]])
        @form.append(Circle[Point[300, 300], 50])
        @form.append(Circle[Point[300, 300], 100])
    end

    def render()
        @form.each do |form|
            form.render_fill()
            form.color = [255, 0, 0]
            form.render()
            form.color = [0, 0, 0]
        end
    end

    def update()
        for i in 0..@form.length() - 1
            next if i == @n
            if collide(@form[@n], @form[i])
                @form[@n].color = [255, 255, 0]
                @form[i].color = [255, 255, 0]
            end
        end
    end


    def event_handler()
        press_Z = Proc.new do
            @form[@n] = @form[@n].move(Vector[0, -2 * delta_time])
        end

        press_S = Proc.new do
            form[@n] = @form[@n].move(Vector[0, 2 * delta_time])
        end

        press_Q = Proc.new do
            form[@n] = @form[@n].move(Vector[-2 * delta_time, 0])
        end

        press_D = Proc.new do
            form[@n] = @form[@n].move(Vector[2 * delta_time, 0])
        end

        press_A = Proc.new do
            @n = @n + 1
            @n = 0 if @n == @form.length()
        end

        press_F = Proc.new do
            form[@n] = @form[@n].turn(1)
        end

        press_G = Proc.new do
            form[@n] = @form[@n].turn(-1)
        end

        on_press(:z, press_Z)
        on_press(:s, press_S)
        on_press(:d, press_D)
        on_press(:q, press_Q)
        on_press(:f, press_F)
        on_press(:g, press_G)
        on_single_press(:a, press_A)

        click_3 = Proc.new do |x, y|
            $gb_var[:scene_change].call(Game2.new())
        end
        on_middle_click(click_3)
    end
end
