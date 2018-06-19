local this = {}
bearLH = this

require("appDefaultsLH")

this.name = "Bear"

function this.app()
   local app = appDefaultsLH.default_app()
   app.replaceTb = this.replacement_table()
   app.useGlobalReplaceTb = true
   return app
end

function this.replacement_table()
   local t = {
      test1 = "t1",
      test2 = "t2"
   }
   return t
end

return this
