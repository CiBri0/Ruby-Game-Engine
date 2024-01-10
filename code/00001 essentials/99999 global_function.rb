def global_function()
    def on_press(key, pr) = $gb_var[:event_handler].on_press(key, pr);

    def on_single_press(key, pr) = $gb_var[:event_handler].on_single_press(key, pr);

    def on_release(key, pr) = $gb_var[:event_handler].on_release(key, pr);

    def on_click(key, pr) = $gb_var[:event_handler].on_click(key, pr);

    def to_rad(x)
        return x * Math::PI / 180
    end

    def to_deg(x)
        return x / Math::PI * 180
    end

    def collide(form1, form2)
        if form1.is_a?(Point) && form2.is_a?(Rectangle)
            return point_collide(form1, form2)
        end

        if form2.is_a?(Point) && form1.is_a?(Rectangle)
            return point_collide(form2, form1)
        end

        if form1.is_a?(Rectangle) && form2.is_a?(Rectangle)
            return rect_collide(form1, form2)
        end

        if form1.is_a?(Triangle) && form2.is_a?(Triangle)
            return triangle_collide(form1, form2)
        end

        if form1.is_a?(Circle) && form2.is_a?(Circle)
            return circle_collide(form1, form2)
        end
    end

    #CIRCLE

    def circle_collide(cir, cir2)
        cirxmax = [cir[0][0], cir2[0][0]].max
        cirxmin = [cir[0][0], cir2[0][0]].min

        cirymax = [cir[0][1], cir2[0][1]].max
        cirymin = [cir[0][1], cir2[0][1]].min

        len = hyp(Vector[cirxmax - cirxmin, cirymax - cirymin])

        return len < cir[1] + cir2[1]
    end

    #TRIANGLE

    def triangle_collide(tri, tri2)
        angles = []

        (get_lines(tri) + get_lines(tri2)).each() do |vec|
            angles.append(get_angle(vec.normalize()) + to_rad(90))
            angles.append(get_angle(vec.normalize()))
        end

        angles.each do |turn|
            return false if !overlap(max_min(turn_tri_from_origin(tri,  turn), 0),
                                     max_min(turn_tri_from_origin(tri2, turn), 0))
        end

        return true
    end

    def turn_tri_from_origin(tri, ang)
        t = []
        tri.each do |vec|
            hy = hyp(vec)
            a = get_angle(vec) + ang
            x = Math.cos(a) * hy
            y = Math.sin(a) * hy
            t.append(Vector[x, y])
        end
        return t
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

    #POINT

    def point_collide(point_coords, quad)
        return true if quad[0] <= point_coords[0] && point_coords[0] <= quad[2] && quad[1] <= point_coords[1] && point_coords[1] <= quad[3]
        return false
    end

    #RECT

    def rect_collide(quad_coord, quad)
        # quad_coord = [[x,y],[x,y],[x,y],[x,y]]
        for i in quad_coord do
            return true if point_collide(i, quad)
        end
        return false
    end
end
