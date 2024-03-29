class App
    def initialize(name:caller[0].split(":")[0] ,w: 480 ,h: 360 ,icon: nil ,start: false, borderless: false, fullscreen: false, fps: 60, zoom: 1, rezisable: false)
        @name = name
        @w = w
        @h = h
        case RbConfig::CONFIG['host_os']
        when /mswin|msys|mingw|cygwin/
          SDL.load_lib(Dir.pwd + '/../code/lib/SDL2.dll', output_error = false, image_libpath: Dir.pwd + '/../code/lib/SDL2_image.dll', mixer_libpath: Dir.pwd + '/../code/lib/SDL2_mixer.dll', ttf_libpath: Dir.pwd + '/../code/lib/SDL2_ttf.dll')
        else
          raise RuntimeError, "Unsupported platform."
        end

        exit if SDL.Init(SDL::INIT_TIMER | SDL::INIT_AUDIO | SDL::INIT_VIDEO | SDL::INIT_GAMECONTROLLER) < 0 || SDL.IMG_Init(SDL::IMG_INIT_PNG) < 0 || SDL.Mix_Init(SDL::MIX_INIT_MP3) < 0 || SDL.Mix_OpenAudio(SDL::MIX_DEFAULT_FREQUENCY, SDL::MIX_DEFAULT_FORMAT, SDL::MIX_DEFAULT_CHANNELS, 4096) < 0 || SDL.TTF_Init < 0

        $gb_var = {
            window: SDL.CreateWindow(name, 32, 32, w, h, SDL::WINDOW_OPENGL),
            renderer: nil,
            running: false,
            current_scene: Scene.new(),
            scene_change: proc do |scene|
                $gb_var[:current_scene].self_del() if $gb_var[:current_scene]
                scene.setup()
                $gb_var[:current_scene] = scene
            end,
            fps: fps.to_f,
            real_fps: 0,
            dt: 1,
            frame_from_start: 0,
            bank: {},
            zoom: zoom,
            h: h,
            w: w,
            base_h: h,
            base_w: w,
            event_handler: Keyboard.new(),
            debug: Debug.new(),
            game: {}
        }



        $gb_var[:real_fps] = $gb_var[:fps]
        $gb_var[:renderer] = SDL.CreateRenderer($gb_var[:window], -1, SDL::RENDERER_ACCELERATED)
        $gb_var[:current_scene].setup()
        SDL.RenderSetLogicalSize($gb_var[:renderer], $gb_var[:w],$gb_var[:h])
        $gb_var[:w] = $gb_var[:w] * $gb_var[:zoom]
        $gb_var[:h] = $gb_var[:h] * $gb_var[:zoom]
        rezize($gb_var[:w], $gb_var[:h])
        @event = SDL::Event.new

        if icon != nil
            SDL.SetWindowIcon($gb_var[:window],Image.load_as_surface(Dir.pwd + "/img/" + icon))
        end

        if borderless
            SDL.SetWindowBordered($gb_var[:window],0);
        end

        if false and rezisable
            SDL.SetWindowResizable($gb_var[:window],1);
        end

        if fullscreen
            sizes = Fiddle::Function.new(Fiddle::dlopen("user32")["GetSystemMetrics"],[Fiddle::TYPE_LONG],Fiddle::TYPE_LONG)
            rezize(sizes.call(0),sizes.call(1))
            SDL.SetWindowFullscreen($gb_var[:window],1);
        end

        start() if start
    end

    def rezize(w,h)
        $gb_var[:w], $gb_var[:h] = w, h
        SDL.SetWindowSize($gb_var[:window], $gb_var[:w], $gb_var[:h])
    end

    def start()
        $gb_var[:running] = true
        $gb_var[:current_scene]
        while $gb_var[:running]
            fps_current = SDL.GetTicks64()

            event_handler()
            update()
            render()

            fps_manager(SDL.GetTicks64() - fps_current)
        end
        quit()
    end

    def event_handler()
        $gb_var[:event_handler].state = false
        while SDL.PollEvent(@event) != 0
            event_type = @event[:common][:type]
            $gb_var[:event_handler].event = @event
            $gb_var[:event_handler].update
            $gb_var[:current_scene].scene_event_handler()
            case event_type
            when SDL::QUIT
                $gb_var[:running] = false
            end
            #event[:key][:keysym][:sym] == SDL::SDLK_a
        end
        $gb_var[:event_handler].state = true

        log($gb_var[:event_handler].keys) if debug().key_state_log
        $gb_var[:current_scene].scene_event_handler()
    end

    def update()
        $gb_var[:current_scene].scene_update()

    end

    def render()
        $gb_var[:current_scene].scene_render()

        SDL.RenderPresent($gb_var[:renderer])
    end

    def fps_manager(dt)
        one_frame = 1000 / $gb_var[:fps] #millisec
        if (one_frame > dt)
            SDL.Delay(one_frame - dt);
            $gb_var[:dt] = 1.0
        else
            $gb_var[:dt] = (dt / (one_frame)) / $gb_var[:fps] * 60
        end
        $gb_var[:real_fps] = $gb_var[:fps] / $gb_var[:dt]
        $gb_var[:frame_from_start] = $gb_var[:frame_from_start] + 1
        log($gb_var[:real_fps]) if debug.fps_log
    end

    def quit()
        $gb_var[:event_handler].self_del()
        $gb_var[:current_scene].self_del()
    end
end
