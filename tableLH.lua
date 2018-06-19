local this = {}
tableLH = this

function this.length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


-- Merge two tables. Overrides common keys with second table
function this.merge(first_table, second_table)
   local t3 = {}
   for k,v in pairs(first_table) do
      t3[k] = v
   end
   for k,v in pairs(second_table) do
      t3[k] = v
   end
   return t3
end


-- Concatenate two tables with sequential keys
function this.concat(t1, t2)
   local t3 = {}
   local i1 = 0
   for k,v in pairs(t1) do
      i1 = i1 + 1
      t3[i1] = v
   end
   for k,v in pairs(t2) do
      i1 = i1 + 1
      t3[i1] = v
   end
   return t3
end

return this
