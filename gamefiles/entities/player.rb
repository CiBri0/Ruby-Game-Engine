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


MAJ : Folder arrangement , better entitities , better file loading , rotation + scale , optimizations , collisions
