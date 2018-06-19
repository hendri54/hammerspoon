local this = {}
windowLH = this


-- Predefined window positions
this.left = 123
this.right = 234


-- Move a window to a given (x,y,w,h) position
function this.move(win, x, y, w, h)
	local f = win:frame()
	if x then
		f.x = x;
	end
	if y then
		assert(y >= 0)
		f.y = y;
	end
	if h then
		assert(h > 10)
		f.h = h;
	end
	if w then
		assert(w > 10)
		f.w = w;
	end
	win:setFrame(f)
end


-- Change window size
--[[
IN:
	win  ::  window handle
	leftRight  ::  predefined window position
	changePct  ::  fraction of screen size * 100
]]
function this.window_size_change(win, leftRight, changePct)
	if not win then
		win = hs.window.focusedWindow()
	end
	local currScreen = win:screen()
  	local screenDims = currScreen:frame()
  	local f = win:frame()

	if leftRight == this.right then
		f.x, f.w = this.change_width_right(f.x, f.w, screenDims, changePct)
	elseif leftRight == this.left then
		f.x, f.w = this.change_width_left(f.x, f.w, screenDims, changePct)
	else
		hs.alert("window_size_change: invalid input")
	end
  	win:setFrame(f)
end


--
function this.fit_win_to_screen_width(x, w, screenDims)
	local wOut = math.min(screenDims.w, w)
	local xOut = x
	local rightEdge = screenDims.x + screenDims.w
	-- bug: cannot call this function:
	-- this.screen_right_edge(screenDims)
	if x + wOut > rightEdge then
		xOut = math.max(screenDims.x, rightEdge - wOut)
	end
	return xOut, wOut
end


-- Return right edge x value of current screen
function this.screen_right_edge(screenDims)
	return screenDims.x + screenDims.w
end


-- Increase or decrease width by adjusting right side
function this.change_width_right(x, w, screenDims, changePct)
	local newWidth = round(w * (1 + changePct / 100))
	xOut, wOut = this.fit_win_to_screen_width(x, newWidth, screenDims)
	return xOut, wOut
end


function this.change_width_left(x, w, screenDims, changePct)
	local newWidth = round(w * (1 + changePct / 100))
	local rightEdge = x + w
	-- wrong with 2 monitors +++
	local newX = math.max(0, rightEdge - newWidth)
	xOut, wOut = this.fit_win_to_screen_width(newX, newWidth, screenDims)
	return xOut, wOut
end


function this.change_position_horizontal(x, w, screenDims, changePct)
	local newX = x + round(screenDims.w * (changePct / 100));
	newX = this.make_x_valid(newX, screenDims);
	xOut, wOut = this.fit_win_to_screen_width(newX, w, screenDims);
	return xOut, wOut
end


-- Given a window x, ensure it is inside the screen
function this.make_x_valid(x, screenDims)
	local newX = math.max(screenDims.x, x);
	newX = math.min(screenDims.x + screenDims.w - 100, newX);
	return newX
end


function this.window_right()
	local win = hs.window.focusedWindow()
	local screenSize = displaysLH.get_screen_size()
	if screenSize == displaysLH.sizeSmall then
		width = 75
	else
		width = 65
	end
	this.position_window(win, nil, this.right, width, 100)
end

function this.window_left()
	local win = hs.window.focusedWindow()
	local screenSize = displaysLH.get_screen_size()
	if screenSize == displaysLH.sizeSmall then
		width = 75
	else
		width = 65
	end
	this.position_window(win, nil, this.left, width, 100)
end


function this.window_right_half()
	local win = hs.window.focusedWindow()
	this.position_window(win, nil, this.right, 50, 100)
end

function this.window_left_half()
	local win = hs.window.focusedWindow()
	this.position_window(win, nil, this.left, 50, 100)
end


-- Grow and shrink windows
function this.window_grow_right(win)
	this.window_size_change(win, this.right, 10)
end

function this.window_grow_left(win)
	this.window_size_change(win, this.left, 10)
end

function this.window_shrink_left(win)
	this.window_size_change(win, this.left, -10)
end

function this.window_shrink_right(win)
	this.window_size_change(win, this.right, -10)
end

function this.move_horizontal(win, changePct)
	assert(changePct > -100  and  changePct < 100)
	if not win then
		win = hs.window.focusedWindow()
	end
	local f = win:frame();
	local screenDims = this.screen_dims(win);
	newX = windowLH.change_position_horizontal(f.x, f.w, screenDims, changePct);
	local xOut, wOut = this.fit_win_to_screen_width(newX, f.w, screenDims);
	windowLH.move(win, xOut, f.y, wOut, f.h);
end

function this.move_right(win, changePct)
	if not changePct then
		changePct = 10;
	else
		assert(changePct >= 0  and  changePct <= 100)
	end
	if not win then
		win = hs.window.focusedWindow()
	end
	this.move_horizontal(win, changePct);
	-- local f = win:frame();
	-- local screenDims = this.screen_dims(win);
	-- newX = windowLH.change_position_horizontal(f.x, f.w, screenDims, changePct);
	-- local xOut, wOut = this.fit_win_to_screen_width(newX, f.w, screenDims);
	-- windowLH.move(win, xOut, f.y, wOut, f.h);
end

function this.move_left(win, changePct)
	if not win then
		win = hs.window.focusedWindow()
	end
	if not changePct then
		changePct = 10;
	else
		assert(changePct >= 0  and  changePct <= 100)
	end
	windowLH.move_horizontal(win, -changePct);
	-- local f = win:frame();
	-- local screenDims = this.screen_dims(win);
	-- newX = windowLH.change_position_horizontal(f.x, f.w, screenDims, 10);
	-- local xOut, wOut = this.fit_win_to_screen_width(newX, f.w, screenDims);
	-- windowLH.move(win, xOut, f.y, wOut, f.h);
end


-- Get center of window (absolute position)
function this.get_win_center(win)
	if not win then
		win = hs.window.focusedWindow()
	end
	local f = win:frame()
	x = f.x + 0.5 * f.w
	y = f.y + 0.5 * f.h
	return x, y
end


-- Position one window
function this.position_window(win, monitorPos, leftRight, widthFraction, heightFraction)
	if not heightFraction then
		heightFraction = 100
	end

	displaysLH.move_win_to_screen(win, monitorPos)
  	local currScreen = win:screen()
  	local screenDims = currScreen:frame()

  	local f = win:frame()
	if leftRight == this.right then
  		f.x = screenDims.x + (screenDims.w * (1 - widthFraction / 100))
  	elseif leftRight == this.left then
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


-- Dimensions of screen for a given window
function this.screen_dims(win)
	if not win then
   	win = hs.window.focusedWindow()
	end
   local currScreen = win:screen()
   local screenDims = currScreen:frame()
   return screenDims
end



function round(x)
   return math.floor(x + 0.5)
end

return this
