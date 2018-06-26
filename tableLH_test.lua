local this = {}
tableLH_test = this

packageLH.reload('tableLH');

function this.test_all()
   this.length_test()
   this.merge_test()
   this.concat_test()
   this.shallow_copy_test()
   this.find_keys_with_duplicate_values_test()
   this.delete_duplicate_values_test()
end


function this.delete_duplicate_values_test()
   local tbIn = {a = 1, b = 2, r1 = 1, r2 = 2};
   tableLH.delete_duplicate_values(tbIn);
   -- this can fail because the order of the table is indeterminate +++++
   -- assert(tableLH.equal(tbIn, {a = 1, b = 2}))
end


function this.find_keys_with_duplicate_values_test()
   local tbIn = {a = 1, b = 2, r1 = 1, r2 = 2};
   local dupKeys = tableLH.find_keys_with_duplicate_values(tbIn);
   -- this can fail because the order of the table is indeterminate +++++
   -- assert(tableLH.equal(dupKeys, {r1 = true, r2 = true}))
end


function this.shallow_copy_test()
   t1 = {"abc", 123};
   t2 = tableLH.shallow_copy(t1);
   assert(tableLH.equal(t1, t2));
   table.insert(t2, "defghi");
   assert(not tableLH.equal(t1, t2));
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
