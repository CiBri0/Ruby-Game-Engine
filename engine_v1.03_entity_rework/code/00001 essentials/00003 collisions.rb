class Shape < Array
    def <=>(other)
        @i <=> other.i
    end
end

class Complexe < Shape #[Triangle, Triangle ...]
    def render(r = 0, g = 0, b = 0)
        self.each do |tri|
            triangle(tri, r, g, b)
        end
    end

    def move(vec)
        t = 0
        c = Complexe[]
        self.each do |tri|
            c[t] = move_tri(tri, vec)
            t = t + 1
        end

        return c
    end

    def i()
        5
    end
end

class Quad < Shape  #[Point, Point, Point, Point]
    def render(r = 0, g = 0, b = 0)
        quad(self, r, g, b)
    end

    def move(vec)
        return move_quad(self, vec)
    end

    def to_complexe()
        return Complexe[Triangle[self[0], self[1], self[3]], Triangle[self[1], self[2], self[3]]]
    end

    def i()
        4
    end
end

class Circle < Shape #[[x, y], radius]
    def render(r = 0, g = 0, b = 0)
        circle(self, r, g, b)
    end

    def move(vec)
        return move_circle(self, vec)
    end

    def i()
        3
    end
end

class Triangle < Shape #[Point, Point, Point]
    def render()
        triangle(self)
    end

    def move(vec)
        return move_tri(self, vec)
    end

    def i()
        2
    end
end

class Point < Vector #[x,y]
    def render(r = 0, g = 0, b = 0)
        pixel(self[0], self[1], r, g, b)
    end

    def x = self[0]

    def x=(x)
        self[0] = x
    end

    def y = self[1]

    def y=(y)
        self[1]= y
    end

    def to_vec()
        return Vector[self[0], self[1]]
    end

    def i()
        0
    end
end

class Vector #[x,y]
    attr_accessor :origin_x, :origin_y
    def render(r = 0, g = 0, b = 0)
        line([@origin_x, @origin_y], [self[0], self[1]], r, g, b)
    end

    def to_vec()
        return self
    end
end



#POINT & TRIANGLE
def area(tri)
    return ((tri[0][0] * (tri[1][1] - tri[2][1]) + tri[1][0] * (tri[2][1] - tri[0][1]) + tri[2][0] * (tri[0][1] - tri[1][1])) / 2.0).abs()
end

def point_triangle_collide(point, tri)
    a = area(tri);

    a1 = area(Triangle[point, Point[tri[1][0], tri[1][1]], Point[tri[2][0], tri[2][1]]])

    a2 = area(Triangle[Point[tri[0][0], tri[0][1]], point, Point[tri[2][0], tri[2][1]]])

    a3 = area(Triangle[Point[tri[0][0], tri[0][1]], Point[tri[1][0], tri[1][1]], point])
   return (a == a1 + a2 + a3);
end

#CIRCLE & CIRCLE

def circle_collide(cir, cir2)

    return hyp(Vector[(cir[0][0] - cir2[0][0]).abs, (cir[0][1] - cir2[0][1]).abs]) < cir[1] + cir2[1]
end

#TRIANGLE & TRIANGLE

def triangle_collide(tri, tri2)
    angles = []

    (get_lines(tri) + get_lines(tri2)).each() do |vec|
        angles.append(get_angle(vec) + to_rad(90))
        angles.append(get_angle(vec))
    end

    angles.each do |turn|
        return false if !overlap(max_min(turn_tri(tri,  turn), 0),
                                    max_min(turn_tri(tri2, turn), 0))
    end

    return true
end

def overlap(tab, tab2)
    return tab.max > tab2.min && tab2.max > tab.min
end

def get_lines(tri)
    return [
        Vector[tri[0][0] - tri[1][0], tri[0][1] - tri[1][1]],
        Vector[tri[1][0] - tri[2][0], tri[1][1] - tri[2][1]],
        Vector[tri[2][0] - tri[0][0], tri[2][1] - tri[0][1]]
    ]
end

def hyp(vec)
    return Math.sqrt(vec[0] ** 2 + vec[1] ** 2)
end

def get_angle(vec)
    return -Math.acos(vec[0] / hyp(vec))
end

def max_min(tri, cat)
    t = []
    tri.each do |vec|
        t.append(vec[cat])
    end
    t.sort!.reverse!
    return [t.max, t.min]
end

#TRIANGLE & CIRCLE

def circle_triangle_collide(tri, cir)
    angles = []
    a = [[], []]
    tri.each do |vec|
        v = Vector[vec[0], vec[1]]
        v.origin_x = cir[0][0]
        v.origin_y = cir[0][1]
        a[0].append(v)
        a[1].append(hyp(v))
    end
    v1 = Vector[cir[0][0] - cir[1], cir[0][1]]
    v1.origin_x = cir[0][0] + cir[1]
    v1.origin_y = cir[0][1]
    (get_lines(tri).append(a[0][a[1].each_with_index.min[1]])).each() do |vec|
        angles.append(get_angle(vec) + to_rad(90))
        angles.append(get_angle(vec))
    end


    angles.each do |turn|
        return false if !overlap(max_min(turn_tri(tri,  turn), 0),
                                         turn_point(Vector[cir[0][0] + cir[1], cir[0][0] - cir[1]], turn))
    end

    return true
end


#RECT & RECT

def rect_collide(quad_coord, quad)
    # quad_coord = [[x,y],[x,y],[x,y],[x,y]]
    for i in quad_coord do
        return true if point_collide(i, quad)
    end
    return false
end


def quad_point_collide(point_coords, quad)
    quad = [quad[0][0], quad[0][1], quad[2][0], quad[2][1]]
    space()
    return true if quad[0] <= point_coords[0] && point_coords[0] <= quad[2] && quad[1] <= point_coords[1] && point_coords[1] <= quad[3]
    return false
end


#TURN (from left up corner)

def turn_tri(tri, ang)
    t = Triangle[]
    tri.each do |vec|
        t.append(turn_point(vec, ang))
    end
    return t
end

def turn_complexe(comp, ang)
    c = Complexe[]
    comp.each do |tri|
        t = Triangle[]
        tri.each do |vec|
            t.append(turn_point(vec, ang))
        end
        c.append(t)
    end
    return c
end

def turn_point(point, ang)
    hy = hyp(point)
    a = get_angle(point) + ang
    x = Math.cos(a) * hy
    y = Math.sin(a) * hy
    return Vector[x, y]
end


#move

def move_tri(tri, vector)
    t = Triangle[]
    tri.each do |vec|
        t.append(vec + vector.to_vec)
    end

    return t
end

def move_quad(quad, vector)
    t = Quad[]
    quad.each do |vec|
        t.append(Point[vec[0] + vector[0], vec[1] + vector[1]])
    end

    return t
end

def move_circle(cir, vector)
    return Circle[cir[0] + vector, cir[1]]
end


#COILLIDE

def collide(form1, form2)
    forms = [form1, form2].sort_by!{|obj| obj.i}.reverse!

    if forms[1].is_a?(Point) && forms[0].is_a?(Triangle)
        return triangle_collide(forms[0], Triangle[forms[1], forms[1], forms[1]])
    end

    if forms[1].is_a?(Point) && forms[0].is_a?(Complexe)
        forms[0].each do |tri|
            return true if point_triangle_collide(forms[1], tri)
        end
        return false
    end

    if forms[1].is_a?(Triangle) && forms[0].is_a?(Complexe)

        forms[0].each do |tri|
            return true if triangle_collide(forms[1], tri)
        end
        return false
    end

    if forms[1].is_a?(Triangle) && forms[0].is_a?(Triangle)
        return triangle_collide(forms[1], forms[0])
    end


    if forms[1].is_a?(Triangle) && forms[0].is_a?(Circle)
        return circle_triangle_collide(forms[1], forms[0])
    end

    if forms[1].is_a?(Circle) && forms[0].is_a?(Complexe)
        forms[0].each do |tri|
            return true if circle_triangle_collide(tri, forms[1])
        end
        return false
    end

    if forms[1].is_a?(Circle) && forms[0].is_a?(Circle)
        return circle_collide(forms[1], forms[0])
    end
end
