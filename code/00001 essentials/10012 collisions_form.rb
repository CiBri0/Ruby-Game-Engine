class Shape < Array
    def color = @color

    def color=(x)
        @color = x
    end

    def <=>(other)
        @i <=> other.i
    end
end

class Complexe < Shape #[Triangle, Triangle ...]
    def render()
        @color = [0, 0, 0] if @color == nil

        self.each do |tri|
            triangle(tri, @color[0], @color[1], @color[2])
        end
    end

    def render_fill()
        @color = [0, 0, 0] if @color == nil

        self.each do |tri|
            triangle_fill(tri, @color[0], @color[1], @color[2])
        end
    end

    def move(vec)
        t = 0
        c = Complexe[]
        self.each do |tri|
            c.append(move_tri(tri, vec.cut(2)))
            t = t + 1
        end

        return c
    end

    def to_s()
        return "Complexe#{self.to_a}"
    end

    def turn(ang)
        return r_turn_complexe(self, ang)
    end

    def i()
        5
    end
end

class Quad < Shape  #[Point x y, Point xw y, Point xw yh, Point x yh]
        def render()
        @color = [0, 0, 0] if @color == nil

        quad(self, @color[0], @color[1], @color[2])
    end

    def render_fill()
        @color = [0, 0, 0] if @color == nil

        render(@color[0], @color[1], @color[2])
    end

    def move(vec)
        t = 0
        c = Quad[]
        self.each do |point|
            c.append(point + vec.cut(2))
            t = t + 1
        end

        return c
    end

    def to_complexe()
        return Complexe[Triangle[self[0], self[1], self[3]], Triangle[self[1], self[2], self[3]]]
    end

    def to_s()
        return "Quad#{self.to_a}"
    end

    def turn(ang)
        return self
    end

    def i()
        4
    end
end

class Circle < Shape #[Point, Radius]
        def render()
        @color = [0, 0, 0] if @color == nil

        circle(self, @color[0], @color[1], @color[2])
    end

    def render_fill()
        color = [0, 0, 0] if @color == nil

        render()
    end

    def move(vec)
        return Circle[self[0] + vec, self[1]]
    end

    def to_s()
        return "Circle#{self.to_a}"
    end

    def turn(ang)
        return self
    end

    def i()
        3
    end
end

class Triangle < Shape #[Point, Point, Point]
        def render()
        @color = [0, 0, 0] if @color == nil

        triangle(self, @color[0], @color[1], @color[2])
    end

    def render_fill()
        @color = [0, 0, 0] if @color == nil

        triangle_fill(self, @color[0], @color[1], @color[2])
    end

    def move(vec)
        return move_tri(self, vec)
    end

    def to_s()
        return "Triangle#{self.to_a}"
    end

    def to_00() #return Triangle
        off = self[0]

        t = Triangle[]
        t.append(Vector[0, 0])  #AC
        t.append(self[1] - off) #AB
        t.append(self[2] - off) #BC
        return t
    end

    def to_vecs() #return Triangle
        t = Triangle[]
        t.append(self[1] - self[0])  #AC
        t.append(self[2] - self[1]) #AB
        t.append(self[0] - self[2]) #BC
        return t
    end

    def to_vert()
        tri = []
        mem  = FFI::MemoryPointer.new(SDL::Vertex, 3)
        self.each_with_index  do |vec, i|
            tri.append(vec.to_vert(mem + SDL::Vertex.size * i))
        end
        return mem
    end

    def turn(ang)
        return r_turn_tri(self, ang, Point[(self[0][0] + self[1][0] + self[2][0]) / 3.0, (self[0][1] + self[1][1] + self[2][1]) / 3.0])
    end

    def i()
        2
    end
end

class Point < Vector #[x,y]
    def color = @color

    def color=(x)
        @color = x
    end

    color = [0, 0, 0]

        def render()
        @color = [0, 0, 0] if @color == nil

        pixel(self[0], self[1], @color[0], @color[1], @color[2])
    end

    def x = self[0]

    def x=(x)
        self[0] = x
    end

    def y = self[1]

    def y=(y)
        self[1] = y
    end

    def to_vec()
        return Vector[self[0], self[1]]
    end

    def to_point()
        return self
    end

    def move(vec)
        return self + vec
    end

    def to_s()
        return "Point#{self.to_a}"
    end

    def turn(ang)
        return self
    end


    def i()
        0
    end
end

class Vector #[x,y]
    attr_accessor :pos

    def color = @color

    def color=(x)
        @color = x
    end

    color = [0, 0, 0]

        def render()
        @color = [0, 0, 0] if @color == nil

        line(@pos, [self[0], self[1]], @color[0], @color[1], @color[2])
    end

    def to_vec()
        return self
    end

    def to_vert(mem)
        fpoint = SDL::FPoint.new()
        vert = SDL::Vertex.new(mem)

        fpoint[:x], fpoint[:y] = self[0], self[1]
        vert[:position] = fpoint
        vert[:@color][:r] = 0
        vert[:@color][:g] = 0
        vert[:@color][:b] = 0
        vert[:@color][:a] = 255

        return vert
    end

    def to_point()
        return Point[self[0], self[1]]
    end

    def cut(n)
        vec = []

        for i in 0..n - 1
            vec.append(self[i])
        end

        return Vector.elements(vec)
    end

    def move(vec)
        return self + vec
    end

    def abs()
        return Vector[self[0].abs, self[1].abs]
    end

    def turn(ang)
        return self
    end

    def to_f()
        self[0] = self[0].to_f
        self[1] = self[1].to_f
    end
end

