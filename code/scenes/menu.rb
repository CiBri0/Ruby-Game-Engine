class Menu < Scene
    def init()
        @background = image("bg.png")
        b = Button.new()
        b.x = 50
        b.y = $gb_var[:h] - 53 * 2 - 50
        add_entity(b)
    end

    def event_handler(event) #M
            case event[:common][:type]
            when SDL::MOUSEBUTTONDOWN
                if event[:button][:button] == 1
                    centisecondes = TestParticle.new()
                    centisecondes.x, centisecondes.y = event[:button][:x] - 64, event[:button][:y] - 64

                    add_entity(centisecondes)
                end

                if event[:button][:button] == 2
                    $gb_var[:scene_change].call(MainScene.new())
                end
            end
    end
end
