local this = {}
displaysLH = this


-- Get monitor configuration
-- OUT:
-- 	"laptop", "office", "single", "unknown"
function this.get_monitor_config()
	monList = hs.screen.allScreens()
	if #monList == 1 then
		if monList[1]:name() == "Color LCD" then
			return "laptop"
		else
			return "single"
		end
	elseif #monList == 2 then
		return "office"
	else
		return "unknown"
	end
end


-- Screen size small or large; assumes same for all screens
function this.get_screen_size()
	local monConfig = this.get_monitor_config()
	if monConfig == "laptop" then
		return "small"
	else
		return "large"
	end
end


function this.get_number_screens()
	return #hs.screen.allScreens()
end




return this
