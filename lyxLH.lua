local this = {}
lyxLH = this

require("appDefaultsLH")


function this.app()
   local app = appDefaultsLH.default_app()
   app.name = "Lyx";
   app.replaceTb = this.replacement_table()
   app.useGlobalReplaceTb = true
   app.windowPos = windowLH.right;
   app.widthFracSmall = 80;
   app.widthFracLarge = 65;
   return app
end


function this.replacement_table()
   local t = {
      luaFunction = "function x() \n \n end",
      luaModule = "local this = {} \nxLH = this \n\n\nreturn this"
   }
   return t
end


return this
