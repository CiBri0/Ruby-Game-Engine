class PlayerBody < Entity
    def init()
        @texturec
    end
end


class Player < Group
    def init()
        add_entity(PlayerBody.new())
    end
end
