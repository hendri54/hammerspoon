local this = {}
appDefaultsLH_test = this

require("appDefaultsLH")

function this.test_all()
   this.default_app_test()
end

function this.default_app_test()
   app = appDefaultsLH.default_app();
   assert(type(app) == "table");
end


return this
