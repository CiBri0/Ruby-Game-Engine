class Keyboard
    attr_accessor :keys, :event, :proc_zero, :state

    def initialize()
        @keys = {a: [SDL::SDLK_a, false], d: [SDL::SDLK_d, false], e: [SDL::SDLK_e, false], q: [SDL::SDLK_q, false], s: [SDL::SDLK_s, false], z: [SDL::SDLK_z, false]}
        @state = false
        @proc_zero = proc do

        end
    end


    def on_press(key, pr)
        return if !@state
        if @keys[key][1] == true
            pr.call()
            return true
        end
        return false
    end

    def on_release(key, pr)
        if @event[:common][:type] == SDL::KEYUP && @event[:key][:keysym][:sym] == @keys[key][0] && @event[:key][:repeat] == 0
            pr.call()
            return true
        end

        return false
    end

    def on_single_press(key, pr)
        if @event[:common][:type] == SDL::KEYDOWN && @event[:key][:keysym][:sym] == @keys[key][0] && @event[:key][:repeat] == 0
            pr.call()
            return true
        end

        return false
    end

    def on_click(key, pr)
        return if @state
        if @event[:common][:type] == SDL::MOUSEBUTTONDOWN && @event[:button][:button] == key
            pr.call(Point[@event[:button][:x] + camera.pos.x, @event[:button][:y] + camera.pos.y])
            return true
        end

        return false
    end

    def on_wheel(pr)
        return if @state
        if @event[:common][:type] == SDL::MOUSEWHEEL
            pr.call(@event[:wheel][:y])
            return true
        end

        return false

    end

    def on_joystick(key, pr)
        if @event[:common][:type] == SDL::CONTROLLERAXISMOTION
            p @event[:value]
        end
    end


    def update()
        @keys.each do |key|
            @keys[key[0]][1] = true if on_single_press(key[0], @proc_zero)
            @keys[key[0]][1] = false if on_release(key[0], @proc_zero)
        end
    end
end
