class PlayerBody < Entity
    def init()
        @texture_path = "boss.png"
    end
end


class Player < EntityGroup
    def init()
        add_entity(PlayerBody.new())
    end
end
