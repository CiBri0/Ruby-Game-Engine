
class Game < Scene
    attr_accessor :form, :n
    def init()
        @form = []
        @n = 0
        @form.append(Triangle[Point[120, 80], Point[200, 100], Point[140, 160]])
        @form.append(Triangle[Point[180, 140], Point[260, 180], Point[180, 200]])
        @form.append(Quad[Point[180, 140], Point[280, 140], Point[280, 240], Point[180, 240]].to_complexe)
        @form.append(Circle[Point[300, 300], 50])
        @form.append(Circle[Point[300, 300], 100])
    end

    def render()
        (@form).each do |form|
            form.render()
        end
    end

    def update()
        for i in 0..@form.length()-1
            next if i == @n
            if collide(@form[@n], @form[i])
                log([@form[@n].class, @form[i].class])
            end
        end
    end


    def event_handler()
        press_Z = Proc.new do |x, y|
            @form[@n] = @form[@n].move(Vector[0, -2])
        end

        press_S = Proc.new do |x, y|
            form[@n] = @form[@n].move(Vector[0, 2])
        end

        press_Q = Proc.new do |x, y|
            form[@n] = @form[@n].move(Vector[-2, 0])
        end

        press_D = Proc.new do |x, y|
            form[@n] = @form[@n].move(Vector[2, 0])
        end

        press_A = Proc.new do |x, y|
            @n = @n + 1
            @n = 0 if @n == @form.length()
            log(form[@n].class)
        end

        on_press(:z, press_Z)
        on_press(:s, press_S)
        on_press(:d, press_D)
        on_press(:q, press_Q)
        on_single_press(:a, press_A)
    end
end
