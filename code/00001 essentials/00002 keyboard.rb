ALPHAS = {a: [SDL::SDLK_a, false], d: [SDL::SDLK_d, false], e: [SDL::SDLK_e, false], f: [SDL::SDLK_f, false], g: [SDL::SDLK_g, false], q: [SDL::SDLK_q, false], s: [SDL::SDLK_s, false], z: [SDL::SDLK_z, false]}
SPECIALS = {ctrl: [SDL::SDLK_LCTRL]}
class Keyboard
    attr_accessor :keys, :event, :proc_zero, :state, :mouse, :x, :y

    def initialize()
        @x = FFI::MemoryPointer.new(:int, 1)
        @y = FFI::MemoryPointer.new(:int, 1)
        @keys = ALPHAS.merge(SPECIALS)
        @state = false
        @proc_zero = proc do

        end
    end


    def on_press(key, pr)
        return if !@state

        if key.is_a?(Array)
            key.each do |k|
                return false if @keys[k][1] == false
            end
            pr.call()
            return true
        else
            if @keys[key][1] == true
                pr.call()
                return true
            end
            return false
        end
    end

    def on_release(key, pr)
        if @event[:common][:type] == SDL::KEYUP && @event[:key][:keysym][:sym] == @keys[key][0] && @event[:key][:repeat] == 0
            pr.call()
            return true
        end

        return false
    end

    def on_single_press(key, pr)
        if key.is_a?(Array)
            key.each do |k|
                return false if @keys[k][1] == false
            end

            pr.call()

            key.each do |k|
                @keys[k][1] = false
            end

        elsif @event[:common][:type] == SDL::KEYDOWN && @event[:key][:keysym][:sym] == @keys[key][0] && @event[:key][:repeat] == 0
            pr.call()
            return true
        end

        return false
    end

    def on_click(key, pr)
        return if @state
        if @event[:common][:type] == SDL::MOUSEBUTTONDOWN && @event[:button][:button] == key
            pr.call(Point[@event[:button][:x], @event[:button][:y]] + camera.pos)
            return true
        end

        return false
    end

    def on_move(pr)
        return if @state
        if @event[:common][:type] == SDL::MOUSEMOTION
            pr.call(Point[@event[:button][:x], @event[:button][:y]] + camera.pos)
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

    def on_resize(pr)
        if @event[:common][:type] == SDL::WINDOWEVENT
            if @event[:window][:event] == SDL::WINDOWEVENT_RESIZED
                pr.call([@event[:window][:data1], @event[:window][:data2]])
                return true
            end
        end

        return false
    end


    def update()
        @keys.each do |key|
            @keys[key[0]][1] = true if on_single_press(key[0], @proc_zero)
            @keys[key[0]][1] = false if on_release(key[0], @proc_zero)
        end

        SDL.GetMouseState(@x, @y)

        @mouse = (Point[@x.read(:int), @y.read(:int)] / $gb_var[:zoom])  + camera.pos

        resize = proc do |t|
            log($gb_var[:w] / $gb_var[:base_w])
            $gb_var[:zoom] = $gb_var[:w].to_f / $gb_var[:base_w].to_f
        end
        on_resize(resize)
    end

    def self_del()
        @x.free
        @y.free
    end
end
