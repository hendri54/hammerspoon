-- ********  Basics

require("constLH")
require("displaysLH")
require("appsLH")
require("hardwareLH")
require("tableLH")
require("uiLH")
require('fileChooserLH')
require("hsLH")
require("windowLH")
require("startupLH")
require("textReplaceLH")
require("keymapLH")
require("vimLH")
require("testLH")



-- Move mouse to center of window
-- move to windowLH +++
function mouse_to_win_center(win)
	local x, y = windowLH.get_win_center(win)
	local p1 = hs.geometry.point(x, y)
	hs.mouse.setAbsolutePosition(p1)
end

-- Configure Hammerspoon
hsLH.config()

-- This must be done last
keymapLH.map_keys()
