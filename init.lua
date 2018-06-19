-- ********  Basics

-- require("testing")
require("constLH")
require("displaysLH")
require("appsLH")
require("hardwareLH")
require("tableLH")
require("uiLH")
require("consoleLH")
require("windowLH")
require("startupLH")
require("textReplaceLH")
require("keymapLH")
require("testLH")

consoleLH.console_config()

-- Disable window animations
hs.window.animationDuration = 0



-- **********  Multiple monitors


-- Move window to a given monitor position
function move_win_to_screen(win, monitorPos)
	if not monitorPos then
		return
	end
	if displaysLH.get_number_screens() == 1 then
		return
	end
	monList = hs.screen.allScreens()
	-- This assumes that main monitor is first in list +++
	if monitorPos == "main" then
		win:moveToScreen(monList[1])
	elseif monitorPos == "left" then
		win:moveToScreen(monList[2])
	end
	mouse_to_win_center(win)
end


-- Move window to next screen
function move_win_to_next_screen(win)
	local monList = hs.screen.allScreens()
	local nScreens = #monList
	if nScreens == 1 then
		return
	end
	if not win then
		win = hs.window.focusedWindow()
	end

	local winIdx = screen_index(win)
	local newIdx = winIdx + 1
	if newIdx > nScreens then
		newIdx = 1
	end
	win:moveToScreen(monList[newIdx])
end


-- Find which screen a window is on
function screen_index(win)
	local currScreen = win:screen()
	local	monList = hs.screen.allScreens()
	local idx1 = nil
	for i1 = 1, #monList do
		if currScreen == monList[i1] then
			idx1 = i1
		end
	end
	return idx1
end


-- ***********  Window positions

-- Position one window
function position_window(win, monitorPos, leftRight, widthFraction, heightFraction)
	if not heightFraction then
		heightFraction = 100
	end

	move_win_to_screen(win, monitorPos)
  	local currScreen = win:screen()
  	local screenDims = currScreen:frame()

  	local f = win:frame()
	if leftRight == "right" then
  		f.x = screenDims.x + (screenDims.w * (1 - widthFraction / 100))
  	elseif leftRight == "left" then
  		f.x = screenDims.x
  	else
  		f.x = screenDims.x
  	end
  f.y = screenDims.y
  f.w = screenDims.w * widthFraction / 100
  f.h = screenDims.h * heightFraction / 100
  win:setFrame(f)
  mouse_to_win_center(win)
end


function window_right()
	local win = hs.window.focusedWindow()
	local screenSize = displaysLH.get_screen_size()
	if screenSize == "small" then
		width = 75
	else
		width = 65
	end
	position_window(win, nil, "right", width, 100)
end

function window_left()
	local win = hs.window.focusedWindow()
	local screenSize = displaysLH.get_screen_size()
	if screenSize == "small" then
		width = 75
	else
		width = 65
	end
	position_window(win, nil, "left", width, 100)
end

function window_right_half()
	local win = hs.window.focusedWindow()
	position_window(win, nil, "right", 50, 100)
end

function window_left_half()
	local win = hs.window.focusedWindow()
	position_window(win, nil, "left", 50, 100)
end


-- Grow and shrink windows
function window_grow_right(win)
	windowLH.window_size_change(win, "right", 10)
end

function window_grow_left(win)
	windowLH.window_size_change(win, "left", 10)
end

function window_shrink_left(win)
	windowLH.window_size_change(win, "left", -10)
end

function window_shrink_right(win)
	windowLH.window_size_change(win, "right", -10)
end

-- Get center of window (absolute position)
function get_win_center(win)
	if not win then
		win = hs.window.focusedWindow()
	end
	local f = win:frame()
	x = f.x + 0.5 * f.w
	y = f.y + 0.5 * f.h
	return x, y
end

-- Move mouse to center of window
function mouse_to_win_center(win)
	local x, y = get_win_center(win)
	local p1 = hs.geometry.point(x, y)
	hs.mouse.setAbsolutePosition(p1)
end



-- This must be done last
keymapLH.map_keys()
