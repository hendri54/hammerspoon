local this = {}
postboxLH = this

require("appDefaultsLH")
require('displaysLH')
require('windowLH')


function this.app()
   local app = appDefaultsLH.default_app()
   app.name = "Postbox";
   app.replaceTb = nil;
   app.useGlobalReplaceTb = true
   app.monitorPos = displaysLH.monLeft;
   app.windowPos = windowLH.left;
   app.widthFracSmall = 80;
   app.widthFracLarge = 70;
   return app
end


-- function this.replacement_table()
--    local t = {
--    }
--    return t
-- end

return this
