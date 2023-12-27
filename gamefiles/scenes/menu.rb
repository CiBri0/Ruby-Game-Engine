class Menu < Scene
    def init()
        @background = image("bg.png")
        b = Button.new()
        b.x = $gb_var[:w] * 1/10
        b.y = $gb_var[:h] * 2/5
        add_entity(b)
    end

    def event_handler(event) #M
        case event[:common][:type]
        when SDL::MOUSEBUTTONDOWN
            if event[:button][:button] == 1
#=begin
                centisecondes = TestParticle.new()
                centisecondes.x, centisecondes.y = event[:button][:x] - 64, event[:button][:y] - 80
                centisecondes.params[:mouse_coords] = true
                add_entity(centisecondes)
#=end
            end

            if event[:button][:button] == 2
                p @entities.length()
=begin
                p "\n"
                p @entities
                p "\n"
                p $gb_var[:current_scene].entity_show()
=end
            end

            if event[:button][:button] == 3
                $gb_var[:scene_change].call(MainScene.new())
            end
        end
    end

    def update()

    end
end
