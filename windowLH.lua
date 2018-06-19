local this = {}
windowLH = this

function this.window_size_change(win, leftRight, changePct)
	if not win then
		win = hs.window.focusedWindow()
	end
	local currScreen = win:screen()
  	local screenDims = currScreen:frame()
  	local f = win:frame()

	if leftRight == "right" then
		f.x, f.w = this.change_width_right(f.x, f.w, screenDims, changePct)
	elseif leftRight == "left" then
		f.x, f.w = this.change_width_left(f.x, f.w, screenDims, changePct)
	else
		hs.alert("window_size_change: invalid input")
	end
  	win:setFrame(f)
end


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


function round(x)
   return math.floor(x + 0.5)
end

return this
