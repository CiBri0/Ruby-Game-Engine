class Button < Entity
    def init()
        @texture_path = "boss.png"
    end

    def event_handler()
        pro = Proc.new do |x,y|
            p [x,y]
        end
        on_click(pro)
    end
end
