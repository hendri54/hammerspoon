local this = {}
matlabLH = this

require("appDefaultsLH")


function this.app()
   local app = appDefaultsLH.default_app()
   app.name = "Matlab";
   app.replaceTb = this.replacement_table()
   app.useGlobalReplaceTb = false
   return app
end

function this.replacement_table()
   local t = {
      classdef = [[classdef < handle
   end]],
      functiontest = [[function tests = test
         test = functiontests(localfunctions)
      end]]
   }
   return t
end

return this
