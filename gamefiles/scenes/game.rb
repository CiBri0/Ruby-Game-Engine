
class Game < Scene
    attr_accessor :form
    def init()
        @form = []
        @form.append(Triangle[Vector[120, 80], Vector[200, 100], Vector[140, 160]])
        @form.append(Triangle[Vector[180, 140], Vector[260, 180], Vector[180, 200]])
        @form.append(Rectangle[Vector[180, 140], Vector[180, 240], Vector[280, 240], Vector[280, 140]])
        @form.append(Circle[Vector[300, 300], 50])
        @form.append(Circle[Vector[300, 300], 100])
    end

    def render()
        @form.each do |form|
            form.render()
        end
    end

    def update()
        if collide(@form[4], @form[3])
            p true
        end
    end


    def event_handler()
        n = 4
        press_Z = Proc.new do |x, y|
            @form[n] = @form[n].translate(Vector[0, -2])
        end

        press_S = Proc.new do |x, y|
            form[n] = @form[n].translate(Vector[0, 2])
        end

        press_Q = Proc.new do |x, y|
            form[n] = @form[n].translate(Vector[-2, 0])
        end

        press_D = Proc.new do |x, y|
            form[n] = @form[n].translate(Vector[2, 0])
        end

        on_press(:z, press_Z)
        on_press(:s, press_S)
        on_press(:d, press_D)
        on_press(:q, press_Q)
    end
end
