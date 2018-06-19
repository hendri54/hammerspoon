local this = {}
tableLH_test = this

function this.test_all()
   this.length_test()
   this.merge_test()
   this.concat_test()
end

function this.length_test()
   local t = {a = 1, b = 2}
   assert(tableLH.length(t) == 2)
end


-- Merge 2 tables
-- hs.fnutils.concat does not work
function this.merge_test()
   local t1 = {a = 1, b = 2}
   local t2 = {[1] = "a", [2] = "b"}
   local t3 = tableLH.merge(t1, t2)

   for k,v in pairs(t1) do
      assert(t3[k] == t1[k])
   end
   for k,v in pairs(t2) do
      assert(t3[k] == t2[k])
   end
end


function this.concat_test()
   local t1 = {a = 1, b = 2}
   local t2 = {[1] = "a", [2] = "b"}
   local t3 = tableLH.concat(t1, t2)

   assert(hs.fnutils.contains(t3, t1.a))
   assert(hs.fnutils.contains(t3, t2[1]))
end

return this
