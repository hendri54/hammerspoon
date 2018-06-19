local this = {}
appsLH_test = this

require("appsLH")


function this.test_all()
   this.appList_test()
   this.app_from_name_test()
end


function this.appList_test()
   local appList = {"matlab", "bear"}
   for k, appName in pairs(appList) do
      local app = appsLH.appList[appName]
      assert(app)
   end
end


function this.app_from_name_test()
   local appList = {"matlab", "bear"}
   for k, appName in pairs(appList) do
      local app = appsLH.app_from_name(appName)
      assert(app)
   end
end


-----------------  Interactive tests

function this.menu_select_test()
	local appName = "TextEdit";
	local menuTb = {"View",  "Zoom In"};
	appsLH.menu_select(appName, menuTb);
end

return this
