module Graphics
    module_function
    def clear(r = 0, g = 0, b = 0)
        color(r, g, b)
        SDL.RenderClear($gb_var[:renderer])
    end

    def pixel(x, y, r = 0, g = 0, b = 0)
        color(r, g, b)
        SDL.RenderDrawPoint($gb_var[:renderer], x, y);
    end

    def color(r = 0, g = 0, b = 0)
        SDL.SetRenderDrawColor($gb_var[:renderer], r, g, b, 255)
    end

    def image(texture_path)
        t = Image.new
        t.setup(path("/img/" + texture_path), $gb_var[:renderer])
        return t
    end
end
