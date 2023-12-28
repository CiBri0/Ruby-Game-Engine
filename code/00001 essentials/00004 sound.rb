require 'sdl2'


class Sound
    def initialize(music_path)
        @path = music_path
    end

    def setup()
        @bgm = SDL.Mix_LoadWAV_RW(SDL.RWFromFile(@path, 'rb'), 1)
        self
    end

    def cleanup()
        SDL.Mix_FreeMusic(@bgm)
        @bgm = nil
    end

    def play(do_loop = true)
       SDL.Mix_PlayMusic(@bgm, do_loop ? -1 : 0)
    end

    def self.fadeout(ms = 500)
       SDL.Mix_FadeOutMusic(ms)
    end

    def self.halt
       SDL.Mix_HaltMusic()
    end
end
