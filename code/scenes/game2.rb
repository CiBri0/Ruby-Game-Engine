class Game2 < Scene
    def init()
        @background = [20, 60, 100]
        add_entity(Flag.new)
        b = Button.new()
        b.pos = Point[50, 50]
        add_entity(b)
    end

    def event_handler() #M
        click_1 = Proc.new do |mouse|
            centisecondes = Water.new()
            centisecondes.pos = mouse
            add_entity(centisecondes)
        end

        on_left_click(click_1)



        click_2 = Proc.new do |x, y|
            centisecondes = Smoke.new()
            centisecondes.pos = mouse
            add_entity(centisecondes)
        end
        on_right_click(click_2)




        click_3 = Proc.new do |x, y|
            $gb_var[:scene_change].call(Menu.new())
        end
        on_middle_click(click_3)

    end

    def update()


=begin
        if Random.rand(20) == 0
            for i in 0..100_000 do
                Math.sin(Math.cos(4481844))/Math.sin(Math.cos(4481844))/Math.sin(Math.cos(4481844))/Math.sin(Math.cos(44818044))/Math.sin(Math.cos(4481844))/Math.sin(Math.cos(4481844))/Math.sin(Math.cos(4481844))
            end
        end
=end
    end

    def render()

    end
end
