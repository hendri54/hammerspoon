local this = {}
displaysLH_test = this

require("displaysLH")

function this.test_all()
   this.get_monitor_config_test()
   this.get_screen_size_test()
end


function this.get_monitor_config_test()
   local mConfig = displaysLH.get_monitor_config()
   assert(type(mConfig) == "string")
end


function this.get_screen_size_test()
   local screenSize = displaysLH.get_screen_size()
   assert(type(screenSize) == "string")
end

return this
