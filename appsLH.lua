-- Start predefined apps and apply win positions
this = {}
appsLH = this

require("displaysLH")
require("windowLH")

-- Each app needs an object with its settings
require("atomLH")
require("bearLH")
require("firefoxLH")
require('lyxLH')
require("matlabLH")
require('pathfinderLH')
require("postboxLH")
require("safariLH")
-- App used for testing UI code
require("textEditLH")


-- List of all applications with settings
-- Need to create a pointer to this before iterating on it
-- Lower case names!
this.appList = {matlab = matlabLH.app(), bear = bearLH.app(),
	atom = atomLH.app(),  firefox = firefoxLH.app(),
	lyx = lyxLH.app(), pathfinder = pathfinderLH.app(),  postbox = postboxLH.app(),
	safari = safariLH.app(),  textedit = textEditLH.app()};


function this.current_app_name()
	local currApp = hs.application.frontmostApplication()
	return currApp:name()
end


-- App object from name
-- Not case sensitive
function this.app_from_name(appName)
	local resultApp = nil;
	-- Cannot iterate on this.appList without making a "copy"
	local appTb = this.appList;
	if not appTb then
		error('appList empty')
	end
	for _, app in pairs(appTb) do
		-- print(hs.inspect(app));
		if string.lower(app.name) == string.lower(appName) then
			resultApp = app;
		end
	end
	return resultApp;
end


-- Start an app and position it
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
function this.position_app(appName)
	if not hs.application.find(appName) then
		return
	end
	local app = this.app_from_name(appName);
	if not app then
		return
	elseif not app.windowPos then
		return
	end

	-- App specific settings
	local heightFraction = 100;
	local monitorPos = app.monitorPos;
	local	winPos = app.windowPos;
	if app.widthFracSmall then
		widthFractionSmall = app.widthFracSmall;
	else
 		widthFractionSmall = 80;
	end
	if app.widthFracLarge then
		widthFractionLarge = app.widthFracLarge;
	else
		widthFractionLarge = 70;
	end

	local screenSize = displaysLH.get_screen_size()
	if screenSize == displaysLH.sizeSmall then
		widthFraction = widthFractionSmall;
	else
		widthFraction = widthFractionLarge;
	end

	hs.application.launchOrFocus(appName)
	local win = hs.window.focusedWindow()
	windowLH.position_window(win, monitorPos, winPos, widthFraction, heightFraction)
end


function this.position_current_app()
	local currentApp = hs.application.frontmostApplication()
	this.position_app(currentApp:name())
end


function this.position_all_apps()
	-- should use app objects +++
	local appList = {"Safari", "Atom", "Firefox", "Lyx", 'Path Finder', "Postbox"}
	local appName = nil

	for i1 = 1, #appList do
		appName = appList[i1]
		if hs.application.find(appName) then
			this.position_app(appName)
		end
	end
end

return this
