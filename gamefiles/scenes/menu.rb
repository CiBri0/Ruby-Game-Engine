class Menu < Scene
    def init()
        @background = image("bg.png")
        b = Button.new()
        b.x = $gb_var[:w] * 1/10
        b.y = $gb_var[:h] * 2/5
        add_entity(b)
    end

    def event_handler() #M
        click_1 = Proc.new do |x, y|
            centisecondes = TestParticle.new()
            centisecondes.x, centisecondes.y = x, y
            centisecondes.params[:mouse_coords] = true
            add_entity(centisecondes)
        end
        $gb_var[:event_handler].on_click(1, click_1)





        click_2 = Proc.new do |x, y|
            p @entities.length()
=begin
            p "\n"
            p @entities
            p "\n"
            p $gb_var[:current_scene].entity_show()
=end
        end
        $gb_var[:event_handler].on_click(2, click_2)




        click_3 = Proc.new do |x, y|
            $gb_var[:scene_change].call(MainScene.new())
        end
        $gb_var[:event_handler].on_click(3, click_3)



        press_A = Proc.new do |x, y|
            p "A !!"
        end
        on_press(:action, press_A)
    end

    def update()

    end

    def render()

    end
end
