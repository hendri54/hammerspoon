local this = {}
constLH_test = this

function this.test_all()
   this.one_test()
   this.lookup_test()
   this.default_app_test()
end

function this.default_app_test()
   app = constLH.default_app()
   assert(app.monitorPos == "main")
end


function this.one_test()
   local t = constLH.constTable
   assert(tableLH.length(t) > 2)
end

function this.lookup_test()
   local out1 = constLH.constant("gmail")
   assert(out1 == "hendricks.lutz@gmail.com")
end

-- function this.matlab_table_test()
--    local t = constLH.matlab_table()
--    local str1 = t["classdef"]
--    assert(#str1 > 10)
-- end
--


return this
