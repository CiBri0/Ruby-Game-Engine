module Graphics
    class Image

        attr_reader :texture
        attr_accessor :flip, :angle, :zoom

        def self.load_as_surface(path)
            rwops = SDL.RWFromFile(path, 'rb')
            img = SDL.IMG_Load_RW(rwops, 1)
            image = SDL::Surface.new(img)
            image
        end

        def initialize
            @rect = SDL::Rect.new
            @rect[:x] = 0
            @rect[:y] = 0
            @rect[:w] = 0
            @rect[:h] = 0

            @original_w = 0
            @original_h = 0

            @texture = nil
            @flip = nil
            @angle = 0
            @zoom = 1
        end
=begin old
        def setup(path, renderer)
            image = Image.load_as_surface(path)
            @texture = SDL.CreateTextureFromSurface(renderer, image)
            @original_w = image[:w]
            @original_h = image[:h]
            @rect[:w] = @original_w
            @rect[:h] = @original_h

            SDL.FreeSurface(image)
        end
=end
#=begin new
        def setup(path, renderer)
            if !$gb_var[:bank].key?(path)
                image = Image.load_as_surface(path)

                $gb_var[:bank][path] = image
            else
                image = $gb_var[:bank][path]
            end

            @texture = SDL.CreateTextureFromSurface(renderer, image)
            @original_w = image[:w]
            @original_h = image[:h]
            @rect[:w] = @original_w
            @rect[:h] = @original_h

        end
#=end

        def cleanup
            SDL.DestroyTexture(@texture)
            @texture = nil
            @original_w = 0
            @original_h = 0
            @rect[:x] = 0
            @rect[:y] = 0
            @rect[:w] = 0
            @rect[:h] = 0
        end

        def x = @rect[:x]

        def x=(x)
            @rect[:x] = x
        end

        def y = @rect[:y]

        def y=(y)
            @rect[:y] = y
        end

        def width = @rect[:w]

        def width=(w)
            @rect[:w] = w
        end

        def height = @rect[:h]

        def height=(h)
            @rect[:h] = h
        end

        def original_width = @original_w

        def original_height = @original_h

        def reset_rect
            # w = FFI::MemoryPointer.new(:int32)
            # h = FFI::MemoryPointer.new(:int32)
            # SDL.QueryTexture(@texture, nil, nil, w, h)

            # @rect[:w] = w.read_int
            # @rect[:h] = h.read_int

            @rect[:w] = @original_w
            @rect[:h] = @original_h
        end

        def render(renderer)
            render_rect(renderer, 0, 0, @rect[:w], @rect[:h])
        end

        def render_rect(renderer, x, y, w, h)
            src_rect = SDL::Rect.new
            src_rect[:x] = x
            src_rect[:y] = y
            src_rect[:w] = w
            src_rect[:h] = h
            hw = @rect[:w]
            hh = @rect[:h]
            @rect[:w] = w
            @rect[:h] = h
            SDL.RenderCopyEx(renderer, @texture, src_rect, multiplie_rect(@rect, @zoom), @angle.to_f, nil, to_flip(@flip))
            @rect[:w] = hw
            @rect[:h] = hh
        end

        def to_flip(flip)
            return FLIP_HORIZONTAL if flip == 1 #horizontal
            return FLIP_VERTICAL if flip == 0 #vertical
            return FLIP_NONE
        end

        def multiplie_rect(r, z)
            t = SDL::Rect.new
            t[:x] = r[:x]
            t[:y] = r[:y]
            t[:w] = r[:w] * z
            t[:h] = r[:h] * z
            return t
        end
    end
end
