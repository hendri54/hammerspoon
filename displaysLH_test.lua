local this = {}
displaysLH_test = this

require("displaysLH")

function this.test_all()
   this.get_monitor_config_test()
   this.get_screen_size_test()
   this.get_monitor_test()
end


function this.get_monitor_test()
   local mon = displaysLH.get_monitor(displaysLH.monMain)
   assert(mon);
   mon2 = displaysLH.get_monitor('notvalid');
   assert(mon2 == mon);
end

function this.get_monitor_config_test()
   local mConfig = displaysLH.get_monitor_config()
   assert(type(mConfig) == type(displaysLH.configLaptop))
end


function this.get_screen_size_test()
   local screenSize = displaysLH.get_screen_size()
   assert(type(screenSize) == type(displaysLH.sizeSmall))
end

return this
