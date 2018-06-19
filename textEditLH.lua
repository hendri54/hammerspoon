local this = {}
textEditLH = this

require("constLH")

function this.app()
   local app = constLH.default_app()
   app.replaceTb = this.replacement_table()
   app.menu = this.menu()
   app.useGlobalReplaceTb = true
   return app
end

function this.replacement_table()
   local t = {
      TextEdit = "current app",
      luaFunction = "function x() \n \n end",
      test1 = "t1",
      test2 = "t2"
   }
   return t
end


function this.menu()
   local choiceTb2 = {Save = function() print("Save selected") end,
      Open = function() print("Open selected") end}
   local choiceTb = {Print = function() print("Print selected") end,
      Submenu = choiceTb2}
   return choiceTb
end

return this
