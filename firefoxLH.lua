local this = {}
firefoxLH = this

require("appDefaultsLH")


function this.app()
   local app = appDefaultsLH.default_app()
   app.name = "Firefox";
   app.replaceTb = {}
   app.useGlobalReplaceTb = true
   app.monitorPos = displaysLH.monLeft;
   app.windowPos = windowLH.right;
   app.widthFracSmall = 80;
   app.widthFracLarge = 70;
   return app
end


return this
