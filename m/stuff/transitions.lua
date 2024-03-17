local transitions = require "monarch.transitions.gui"

local M = {}

local DEFAULT_BLACK_TIME = 0.2;
M.max_alpha = 0.8

function M.apply_black_transitions(transition, gui_node, time)
    if not time then
        time = DEFAULT_BLACK_TIME;
    end
    
    transition
    .show_in(gui_node, transitions.fade_out, gui.EASING_INQUAD, time, 0)
    .show_out(gui_node, transitions.fade_in, gui.EASING_OUTQUAD, time, 0)
end

function M.fade_in_custom(node, from, easing, duration, delay, cb)
	local to = gui.get_color(node)
	to.w = 0
	gui.set_color(node, to)
	to.w = M.max_alpha
	gui.animate(node, gui.PROP_COLOR, to, easing, duration, delay, cb)
end

function M.fade_out_custom(node, from, easing, duration, delay, cb)
	local to = gui.get_color(node)
	to.w = M.max_alpha
	gui.set_color(node, to)
	to.w = 0
	gui.animate(node, gui.PROP_COLOR, to, easing, duration, delay, cb)
end

return M