class Button < Entity
    def init()
        @texture_path = "boss.png"
    end

    def event_handler(event)
        pro = Proc.new do |x,y|
            p [x,y]
        end
        on_click(event, pro)
    end
end
