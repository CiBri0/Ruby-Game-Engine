
class Rectangle < Array
    def render()
        quad(self)
    end

    def translate(vec)
        return translate_quad(self, vec)
    end
end

class Circle < Array
    def render()
        circle(self)
    end

    def translate(vec)
        return translate_circle(self, vec)
    end
end


class Point < Array
    def render()
        pixel(self[0], self[1])
    end

    def translate(vec)
        return translate_circle(self, vec)
    end
end

class Triangle < Array
    def render()
        triangle(self)
    end

    def translate(vec)
        return translate_tri(self, vec)
    end
end


