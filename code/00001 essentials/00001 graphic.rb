module Graphic
    module_function
    FLIP_NONE = 0b00
    FLIP_HORIZONTAL = 0b01
    FLIP_VERTICAL = 0b10
    def clear(r = 0, g = 0, b = 0)
        color(r, g, b)
        SDL.RenderClear($gb_var[:renderer])
    end

    def pixel(x, y, r = 0, g = 0, b = 0)
        color(r, g, b)
        SDL.RenderDrawPoint($gb_var[:renderer], x, y);
        color(255, 255, 255)
    end

    def color(r = 0, g = 0, b = 0)
        SDL.SetRenderDrawColor($gb_var[:renderer], r, g, b, 255)
    end

    def line(vec, vec2, r = 0, g = 0, b = 0)
        x0, x1, y0, y1 = vec[0].floor, vec2[0].floor, vec[1].floor, vec2[1].floor

        dx = (x1 - x0).abs
        sx = x0 < x1 ? 1 : -1
        dy = -(y1 - y0).abs
        sy = y0 < y1 ? 1 : -1
        error = dx + dy

        while true
            pixel(x0, y0, r, g, b)
            break if x0 == x1 && y0 == y1;
            e2 = 2 * error
            if e2 >= dy
                break if x0 == x1;
                error = error + dy
                x0 = x0 + sx
            end

            if e2 <= dx
                break if y0 == y1;
                error = error + dx
                y0 = y0 + sy
            end
        end
    end

    def triangle(tri, r = 0, g = 0, b = 0)
        line(tri[0], tri[1], r, g, b)
        line(tri[1], tri[2], r, g, b)
        line(tri[2], tri[0], r, g, b)
    end

    def translate_tri(tri, vector)
        t = Triangle[]
        tri.each do |vec|
            t.append(vec + vector)
        end

        return t
    end

    def quad(rec, r = 0, g = 0, b = 0)
        line(rec[0], rec[1], r, g, b)
        line(rec[1], rec[2], r, g, b)
        line(rec[2], rec[3], r, g, b)
        line(rec[3], rec[0], r, g, b)
    end

    def translate_quad(rec, vector)
        t = Rectangle[]
        rec.each do |vec|
            t.append(vec + vector)
        end

        return t
    end

    def circle(cir, r = 0, g = 0, b = 0)
        t1 = 0
        x = cir[1]
        y = 0

        while x > y
            pixel(x + cir[0][0], y + cir[0][1])
            pixel(-x + cir[0][0], y + cir[0][1])
            pixel(-x + cir[0][0], -y + cir[0][1])
            pixel(x + cir[0][0], -y + cir[0][1])

            pixel(y + cir[0][0], x + cir[0][1])
            pixel(-y + cir[0][0], x + cir[0][1])
            pixel(-y + cir[0][0], -x + cir[0][1])
            pixel(y + cir[0][0], -x + cir[0][1])


            y = y + 1
            t1 = t1 + y
            t2 = t1 - x
            if t2 >= 0
                t1 = t2
                x = x - 1
            end
        end
    end

    def translate_circle(cir, vector)
        return Circle[cir[0] + vector, cir[1]]
    end

    def image(texture_path)
        t = Image.new
        t.setup(path("/img/" + texture_path), $gb_var[:renderer])
        return t
    end
end
