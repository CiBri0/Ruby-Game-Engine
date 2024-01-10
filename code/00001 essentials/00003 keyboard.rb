class Keyboard
    attr_accessor :keys, :event

    def initialize()
        @keys = {a: SDL::SDLK_a, d: SDL::SDLK_d, q: SDL::SDLK_q, s: SDL::SDLK_s, z: SDL::SDLK_z}
    end

    
    def on_press(key, pr)
        case @event[:common][:type]
        when SDL::KEYDOWN
            pr.call() if @event[:key][:keysym][:sym] == @keys[key]
        end
    end

    def on_release(key, pr)
        case @event[:common][:type]
        when SDL::KEYUP
            pr.call() if @event[:key][:keysym][:sym] == @keys[key]
        end
    end

    def on_single_press(key, pr)
        case @event[:common][:type]
        when SDL::KEYDOWN
            pr.call() if @event[:key][:keysym][:sym] == @keys[key] && event[:key][:repeat] == 0
        end
    end

    def on_click(key, pr)
        case @event[:common][:type]
        when SDL::MOUSEBUTTONDOWN
            if @event[:button][:button] == key
                pr.call(@event[:button][:x], @event[:button][:y])
            end
        end
    end

    def on_joystick(key, pr)
        case @event[:common][:type]
        when SDL::CONTROLLERAXISMOTION
            p @event[:value]
        end
    end
end
