#Graphics
def clear(r = 0, g = 0, b = 0)
    acolor(r, g, b)
    SDL.RenderClear($gb_var[:renderer])
end

def pixel(x, y, r = 0, g = 0, b = 0)
    acolor(r, g, b)
    SDL.RenderDrawPoint($gb_var[:renderer], x, y);
    acolor(255, 255, 255)
end

def acolor(r = 0, g = 0, b = 0)
    SDL.SetRenderDrawColor($gb_var[:renderer], r, g, b, 255)
end


def line(point, point2, r = 0, g = 0, b = 0)
    acolor(r, g, b)
    SDL.RenderDrawLine($gb_var[:renderer], point[0], point[1], point2[0], point2[1])
    acolor(255, 255, 255)
end

def triangle(tri, r = 0, g = 0, b = 0)
    line(tri[0], tri[1], r, g, b)
    line(tri[1], tri[2], r, g, b)
    line(tri[2], tri[0], r, g, b)
end

def triangle_fill(tri, r = 0, g = 0, b = 0)

    p1, p2, p3 = tri.map { |point| point.to_a.map(&:to_f) }

    p1, p2 = p2, p1 if p2[1] < p1[1]
    p2, p3 = p3, p2 if p3[1] < p2[1]
    p1, p2 = p2, p1 if p2[1] < p1[1]

    s1 = (p3[1] - p1[1]) / (p3[0] - p1[0])
    s2 = (p2[1] - p1[1]) / (p2[0] - p1[0])
    s3 = (p3[1] - p2[1]) / (p3[0] - p2[0])

    y = p1[1]

    while y < p3[1]
        x1 = (y - p1[1]) / s1 + p1[0]
        x2 = (y < p2[1] ? y - p1[1] : y - p2[1]) / (y < p2[1] ? s2 : s3) + (y < p2[1] ? p1[0] : p2[0])

        line(Point[x1, y], Point[x2, y], r, g, b)

        y += 1
    end
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
    xo = cir[0][0]
    yo = cir[0][1]

    while x > y
        pixel(x + xo, y + yo)
        pixel(-x + xo, y + yo)
        pixel(-x + xo, -y + yo)
        pixel(x + xo, -y + yo)

        pixel(y + xo, x + yo)
        pixel(-y + xo, x + yo)
        pixel(-y + xo, -x + yo)
        pixel(y + xo, -x + yo)


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
