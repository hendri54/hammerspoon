-- Display configurations; mainly for multi-monitor setup
local this = {}
displaysLH = this


-- Defined monitor configurations
this.configLaptop = 43;
this.configSingle = 44;
this.configOffice = 45;
this.configUnknown = 46;

-- Defined screen sizes
this.sizeSmall = 51;
this.sizeLarge = 52;

-- Defined monitor positions
this.monMain = 83;
this.monLeft = 84;


-- Get monitor configuration
-- OUT:
-- 	configLaptop etc
function this.get_monitor_config()
	monList = hs.screen.allScreens()
	if #monList == 1 then
		if monList[1]:name() == "Color LCD" then
			return this.configLaptop
		else
			return this.configSingle
		end
	elseif #monList == 2 then
		return this.configOffice
	else
		return this.configUnknown
	end
end


-- Screen size small or large; assumes same for all screens
function this.get_screen_size()
	local monConfig = this.get_monitor_config()
	if monConfig == this.configLaptop then
		return this.sizeSmall
	else
		return this.sizeLarge
	end
end


function this.get_number_screens()
	return #hs.screen.allScreens()
end


-- Return a named monitor. If it does not exist, return main monitor
function this.get_monitor(monitorPos)
	monList = hs.screen.allScreens()
	-- This assumes that main monitor is first in list +++
	if monitorPos == displaysLH.monMain then
		return monList[1]
	elseif monitorPos == displaysLH.monLeft then
		return monList[2]
	else
		return monList[1]
	end
end


-- Move window to a given monitor position
function this.move_win_to_screen(win, monitorPos)
	if not monitorPos then
		return
	end
	if this.get_number_screens() == 1 then
		return
	end
	local mon = this.get_monitor(monitorPos);
	win:moveToScreen(mon)
	mouse_to_win_center(win)
end


-- Move window to next screen
function this.move_win_to_next_screen(win)
	local monList = hs.screen.allScreens()
	local nScreens = #monList
	if nScreens == 1 then
		return
	end
	if not win then
		win = hs.window.focusedWindow()
	end

	local winIdx = this.screen_index(win)
	local newIdx = winIdx + 1
	if newIdx > nScreens then
		newIdx = 1
	end
	win:moveToScreen(monList[newIdx])
end


-- Find which screen a window is on
function this.screen_index(win)
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



return this
