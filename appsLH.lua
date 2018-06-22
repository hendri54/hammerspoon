-- Start predefined apps and apply win positions
this = {}
appsLH = this

require("displaysLH")
require("windowLH")

require("atomLH")
require("bearLH")
require("firefoxLH")
require('lyxLH')
require("matlabLH")
require("postboxLH")
require("safariLH")
-- App used for testing UI code
require("textEditLH")

-- List of all applications with settings
-- Lower case names!
this.appList = {matlab = matlabLH.app(), bear = bearLH.app(),
	atom = atomLH.app(),  firefox = firefoxLH.app(),
	lyx = lyxLH.app(),  postbox = postboxLH.app(),
	safari = safariLH.app(),  textedit = textEditLH.app()};


function this.current_app_name()
	local currApp = hs.application.frontmostApplication()
	return currApp:name()
end


-- App object from name
-- Not case sensitive
function this.app_from_name(appName)
	return this.appList[string.lower(appName)]
end


-- Start an app
function this.start_app(appName)
	hs.application.launchOrFocus(appName)
	this.position_app(appName)
end


-- Select menu item
function this.menu_select(appName, menuTb)
	local launched = hs.application.launchOrFocus(appName)
	if not launched then
		hs.alert("Could not launch app " .. appName)
		return
	end
   local app = hs.appfinder.appFromName(appName)
   if not app then
   	hs.alert("Cannot find app " .. appName)
   	return
   end
	app:selectMenuItem(menuTb)
end


-----------------------------------------
-- Apply window positions to main apps
-- Only if app is running
-- Update using settings for apps in appsLH +++
function this.position_app(appName)
	if not hs.application.find(appName) then
		return
	end
	local screenSize = displaysLH.get_screen_size()

	-- Defaults
	local winPos = nil
	local monitorPos = displaysLH.monMain
	local widthFractionLarge = 70;
	local widthFractionSmall = 80;
	local heightFraction = 100;

	-- App specific settings
	local app = this.app_from_name(appName);
	if app then
		monitorPos = app.monitorPos;
		if app.windowPos then
			winPos = app.windowPos;
		end
		if app.widthFracSmall then
			widthFractionSmall = app.widthFracSmall;
		end
		if app.widthFracLarge then
			widthFractionLarge = app.widthFracLarge;
		end
	end

	if screenSize == displaysLH.sizeSmall then
		widthFraction = widthFractionSmall;
	else
		widthFraction = widthFractionLarge;
	end

	if appName == "BBEdit" then
		winPos = windowLH.left
		widthFraction = 60
		if screenSize == displaysLH.sizeSmall then
			widthFraction = 80
		end
	elseif appName == "Pathfinder" then
		winPos = windowLH.right
		widthFraction = 75
	end

	if winPos then
		hs.application.launchOrFocus(appName)
		local win = hs.window.focusedWindow()
		windowLH.position_window(win, monitorPos, winPos, widthFraction, heightFraction)
	end
end


function this.position_current_app()
	local currentApp = hs.application.frontmostApplication()
	this.position_app(currentApp:name())
end


function this.position_all_apps()
	local appList = {"Safari", "BBEdit", "Atom", "Lyx", "Postbox"}
	local appName = nil

	for i1 = 1, #appList do
		appName = appList[i1]
		if hs.application.find(appName) then
			this.position_app(appName)
		-- else
		-- 	hs.alert.show(appName .. " not found")
		end
	end
end

return this
