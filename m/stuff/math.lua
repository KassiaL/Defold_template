local M = {}

---comment
---@param v1 number
---@param v2 number
---@param l number
---@return number
function M.lerp(v1, v2, l)
	return (v2 - v1) * l + v1
end

---return new angle
---@param main_angle number
---@param angle2 number
---@return number
function M.set_angle_less_360(main_angle, angle2)
	local v = math.abs(main_angle - angle2)
	if math.abs(main_angle - (angle2 + 360)) < v then
		angle2 = angle2 + 360
	elseif math.abs(main_angle - (angle2 - 360)) < v then
		angle2 = angle2 - 360
	end

	--[[if math.abs(angle2 - main_angle) > 360 then
		if angle2 - main_angle < 0 then
			angle2 = angle2 - 360
		else
			angle2 = angle2 + 360
		end
	end]]--

	return angle2
end

---set vector without creating new
---@param original vector3
---@param copy vector3
function M.vector_set(original, copy)
	copy.x = original.x;
	copy.y = original.y;
	copy.z = original.z;
	return copy
end

---@param point vector3
---@param angle_radians number
---@return vector3
function M.rotate_point(point, angle_radians)
	point.x = math.cos(angle_radians) * point.x - point.y * math.sin(angle_radians)
	point.y = math.sin(angle_radians) * point.x + point.y * math.cos(angle_radians)
	return point
end

---@param point vector3
---@param angle_radians number
---@param point_around_rotate vector3
---@return vector3
function M.rotate_point_around_point(point, angle_radians, point_around_rotate)
	point.x = math.cos(angle_radians) * (point.x - point_around_rotate.x) - (point.y - point_around_rotate.y) * math.sin(angle_radians)
	point.y = math.sin(angle_radians) * (point.x - point_around_rotate.x) + (point.y - point_around_rotate.y) * math.cos(angle_radians)
	return point
end

---get angle of vector
---@param vector vector3
---@return number
function M.angle(vector)
	return math.atan2(vector.y, vector.x) * 180 / math.pi
end

---@param vec1 vector3
---@param vec2 vector3
---@return number
function M.distance(vec1, vec2)
	local x = vec1.x - vec2.x
	local y = vec1.y - vec2.y
	return math.sqrt(x * x + y * y)
end

---comment
---@param p1 vector3
---@param p2 vector3
---@param p3 vector3
---@return number
function M.area_triangle(p1, p2, p3)
	return math.abs((p2.x * p1.y - p1.x * p2.y) + (p3.x * p2.y - p2.x * p3.y) + (p1.x * p3.y - p3.x * p1.y)) / 2
end

---@param rect_pos vector3
---@param half_width number
---@param half_height number
---@param angle_radians number
---@param point_coords vector3
---@return boolean
function M.is_point_in_rotated_rectangle(rect_pos, half_width, half_height, angle_radians, point_coords)
	local p0 = vmath.vector3(point_coords.x, point_coords.y, 0)
	local p1 = vmath.vector3(rect_pos.x - half_width, rect_pos.y - half_height, 0)
	p1 = M.rotate_point_around_point(p1, angle_radians, rect_pos)
	local p2 = vmath.vector3(rect_pos.x - half_width, rect_pos.y + half_height, 0)
	p2 = M.rotate_point_around_point(p2, angle_radians, rect_pos)
	local p3 = vmath.vector3(rect_pos.x + half_width, rect_pos.y + half_height, 0)
	p3 = M.rotate_point_around_point(p3, angle_radians, rect_pos)
	local p4 = vmath.vector3(rect_pos.x + half_width, rect_pos.y - half_height, 0)
	p4 = M.rotate_point_around_point(p4, angle_radians, rect_pos)
	---triangles p0p1p2 p0p2p3 p0p3p4 p0p4p1
	local rect_area = half_width * 2 * half_height * 2
	local triangles_area = M.area_triangle(p0, p1, p2) + M.area_triangle(p0, p2, p3) + M.area_triangle(p0, p3, p4) + M.area_triangle(p0, p4, p1)
	return rect_area >= triangles_area - 0.5
end

---@param rect_pos vector3
---@param half_width number
---@param half_height number
---@param point_coords vector3
---@return boolean
function M.is_point_in_rectangle(rect_pos, half_width, half_height, point_coords)
	return rect_pos.x + half_width > point_coords.x and rect_pos.x - half_width < point_coords.x and rect_pos.y + half_height > point_coords.y and rect_pos.y - half_height < point_coords.y
end

---@param table table
---@param value any
---@return any
function M.contain_ipairs(table, value)
	for i, v in ipairs(table) do
		if v == value then
			return v
		end
	end
	return nil
end

---@param table table
---@param value any
---@return integer | nil
function M.get_index(table, value)
	for i, v in ipairs(table) do
		if v == value then
			return i
		end
	end
	return nil
end

return M