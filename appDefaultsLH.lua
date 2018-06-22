local this = {}
appDefaultsLH = this

require("displaysLH")


-- Template for apps
--[[
Since there is no usable OOP, this is my way of creating inheritance
]]
function this.default_app()
	local app = {}
	-- Text replacement table
	app.replaceTb = nil;
	app.useGlobalReplaceTb = true;
	app.monitorPos = displaysLH.monMain;
	app.windowPos = nil;
	app.widthFracSmall = nil;
	app.widthFracLarge = nil;
	-- App specific menu
	app.menu = nil;
	return app
end

return this
