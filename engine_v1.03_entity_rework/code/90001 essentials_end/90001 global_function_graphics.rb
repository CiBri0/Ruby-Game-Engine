#Graphics
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


def line(point, point2, r = 0, g = 0, b = 0)
    x0, x1, y0, x2 = point[0].floor, point2[0].floor, point[1].floor, point2[1].floor

    dx = (x1 - x0).abs
    sx = x0 < x1 ? 1 : -1
    dy = -(x2 - y0).abs
    sy = y0 < x2 ? 1 : -1
    error = dx + dy

    while true
        pixel(x0, y0, r, g, b)
        break if x0 == x1 && y0 == x2;
        e2 = 2 * error
        if e2 >= dy
            break if x0 == x1;
            error = error + dy
            x0 = x0 + sx
        end

        if e2 <= dx
            break if y0 == x2;
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

def quad(rec, r = 0, g = 0, b = 0)
    line(rec[0], rec[1], r, g, b)
    line(rec[1], rec[2], r, g, b)
    line(rec[2], rec[3], r, g, b)
    line(rec[3], rec[0], r, g, b)
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



def image(texture_path)
    t = Image.new
    t.setup(path("/img/" + texture_path), $gb_var[:renderer])
    return t
end

def to_rad(x)
    return x * Math::PI / 180
end

def to_deg(x)
    return x / Math::PI * 180
end
