local this = {}
firefoxLH = this

require("appDefaultsLH")

this.name = "Firefox";

function this.app()
   local app = appDefaultsLH.default_app()
   app.replaceTb = {}
   app.useGlobalReplaceTb = true
   app.monitorPos = displaysLH.monLeft;
   app.windowPos = windowLH.right;
   app.widthFracSmall = 80;
   app.widthFracLarge = 70;
   return app
end


return this
