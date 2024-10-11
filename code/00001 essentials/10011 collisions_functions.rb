

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

def triangle_collide(triangle1, triangle2)
    axes = []
    triangle1.to_vecs.each { |edge| axes << [edge[1], -edge[0]] }
    triangle2.to_vecs.each { |edge| axes << [edge[1], -edge[0]] }

    axes.each do |axis|
        min1, max1 = project_triangle(triangle1, axis)
        min2, max2 = project_triangle(triangle2, axis)
        return false if max1 < min2 || max2 < min1
    end

    return true
end

    def project_triangle(triangle, axis)
    min = max = triangle[0][0] * axis[0] + triangle[0][1] * axis[1]
    triangle.each do |vertex|
        projection = vertex[0] * axis[0] + vertex[1] * axis[1]
        min = projection if projection < min
        max = projection if projection > max
    end
    return [min, max]
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
        c.append(turn_tri(ang))
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

# (from barycenter)

def r_turn_point(point, angle)
    x, y = point
    a = to_rad(angle)
    rotated_x = Math.cos(a) * x - Math.sin(a) * y
    rotated_y = Math.sin(a) * x + Math.cos(a) * y
    Point[rotated_x, rotated_y]
end

def r_turn_tri(triangle, angle, center)
    center_x = center[0]
    center_y = center[1]
    rotated_triangle = Triangle[]
    triangle.each do |point|
        centered_point = [point[0] - center_x, point[1] - center_y]
        rotated_point = r_turn_point(centered_point, angle)
        rotated_point[0] += center_x
        rotated_point[1] += center_y
        rotated_triangle << rotated_point
    end
    return rotated_triangle
end

def tri_center(triangle)
    center_x = (triangle[0][0] + triangle[1][0] + triangle[2][0]) / 3.0
    center_y = (triangle[0][1] + triangle[1][1] + triangle[2][1]) / 3.0
    Point[center_x, center_y]
end

def complexe_center(poly_triangles)
    total_weight = 0
    weighted_sum_x = 0
    weighted_sum_y = 0

    poly_triangles.each do |triangle|
        t = tri_center(triangle)
        triangle_center_x, triangle_center_y = t[0], t[1]
        area = area(triangle)
        total_weight += area
        weighted_sum_x += triangle_center_x * area
        weighted_sum_y += triangle_center_y * area
    end

    center_x = weighted_sum_x / total_weight
    center_y = weighted_sum_y / total_weight

    return Point[center_x, center_y]
end


def r_turn_complexe(comp, ang)
    c = Complexe[]
    center = complexe_center(comp)
    comp.each do |tri|
        c.append(r_turn_tri(tri, ang, center))
    end
    return c
end

#MOVE

def move_tri(tri, vector)
    t = Triangle[]
    tri.each do |vec|

        t.append((vec.to_vec + vector.to_vec).to_point)
    end

    return t
end

def move_quad(quad, vector)
    t = Quad[]
    quad.each do |vec|
        t.append((vec.to_vec + vector.to_vec).to_point)
    end

    return t
end

def move_circle(cir, vector)
    return Circle[cir[0] + vector, cir[1]]
end

#POLYGON

def is_ear(polygon, i)
    n = polygon.length
    prev_index = (i - 1) % n
    next_index = (i + 1) % n

    p0 = polygon[prev_index]
    p1 = polygon[i]
    p2 = polygon[next_index]

    cross_product = (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1])

    return false if cross_product <= 0

    triangle = [p0, p1, p2]
    polygon.each_with_index do |point, index|
        next if [prev_index, i, next_index].include?(index)

        return false if point_triangle_collide(point, triangle)
    end

    return true
end

def triangulate(polygon)
    c = polygon.length
    pol = polygon.clone
    n = c
    triangles = Complexe[]
    while n > 3
        ear_index = nil

        pol.each_with_index do |_, i|
            next unless is_ear(pol, i)

            ear_index = i
            break
        end

        break if ear_index.nil?

        prev_index = (ear_index - 1) % pol.length
        next_index = (ear_index + 1) % pol.length

        triangles.append(Triangle[pol[prev_index], pol[ear_index], pol[next_index]])

        pol.delete_at(ear_index)
        n -= 1
    end

    triangles << pol if n == 3

    return triangles if triangles.length == c - 2

    return triangulate(polygon.reverse)
end




#COLLIDE

def collide(form1, form2)
    forms = [form1, form2].sort_by!{|obj| obj.i}.reverse!
    if forms[1].is_a?(Point) && forms[0].is_a?(Triangle)
        return point_triangle_collide(forms[1], forms[0])
    end

    if forms[1].is_a?(Point) && forms[0].is_a?(Complexe)
        forms[0].each do |tri|
            return true if point_triangle_collide(forms[1], tri)
        end
        return false
    end

    if forms[1].is_a?(Triangle) && forms[0].is_a?(Triangle)
        return triangle_collide(forms[1], forms[0])
    end

    if forms[1].is_a?(Triangle) && forms[0].is_a?(Complexe)
        forms[0].each do |tri|
            log([forms[1], tri]) if triangle_collide(forms[1], tri)
            return true if triangle_collide(forms[1], tri)
        end
        return false
    end

    if forms[1].is_a?(Complexe) && forms[0].is_a?(Complexe)
        forms[0].each do |tri|
            forms[1].each do |tri2|
                return true if triangle_collide(tri2, tri)
            end
        end
        return false
    end


    # if forms[1].is_a?(Triangle) && forms[0].is_a?(Circle)
    #     return circle_triangle_collide(forms[1], forms[0])
    # end

    # if forms[1].is_a?(Circle) && forms[0].is_a?(Complexe)
    #     forms[0].each do |tri|
    #         return true if circle_triangle_collide(tri, forms[1])
    #     end
    #     return false
    # end

    if forms[1].is_a?(Circle) && forms[0].is_a?(Circle)
        return circle_collide(forms[1], forms[0])
    end
end
