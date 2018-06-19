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


-- Disable window animations
hs.window.animationDuration = 0



-- Move mouse to center of window
function mouse_to_win_center(win)
	local x, y = windowLH.get_win_center(win)
	local p1 = hs.geometry.point(x, y)
	hs.mouse.setAbsolutePosition(p1)
end

consoleLH.console_config()

-- This must be done last
keymapLH.map_keys()
