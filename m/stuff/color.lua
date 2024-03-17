local M = {}

---comment
---@param hex string
---@param alpha number | nil
---@return number
---@return number
---@return number
---@return number | nil
local function hex (hex, alpha) 
	local redColor,greenColor,blueColor=hex:match('#?(..)(..)(..)')
	redColor, greenColor, blueColor = tonumber(redColor, 16)/255, tonumber(greenColor, 16)/255, tonumber(blueColor, 16)/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	end
	return redColor, greenColor, blueColor, alpha
end

---comment
---@param hexCl string
---@param alpha number | nil
---@return vector4
local function hexV (hexCl, alpha) 
	local redColor, greenColor, blueColor, alpha = hex(hexCl, alpha)
	if alpha == nil then
		return vmath.vector4(redColor, greenColor, blueColor, 1)
	else
		return vmath.vector4(redColor, greenColor, blueColor, alpha)
	end
end

local function rgb (r, g, b)
	local redColor,greenColor,blueColor=r/255, g/255, b/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	return redColor, greenColor, blueColor
end

local function rgba (r, g, b, alpha)
	local redColor,greenColor,blueColor=r/255, g/255, b/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	return redColor, greenColor, blueColor, alpha
end

M.hex = hex
M.hexV = hexV
M.rgb = rgb
M.rgba = rgba

return M