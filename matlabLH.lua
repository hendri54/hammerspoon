local this = {}
matlabLH = this

require("constLH")

function this.app()
   local app = constLH.default_app()
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
