local this = {}
tableLH = this


-- Delete duplicate table values (in place)
function this.delete_duplicate_values(tbIn)
   if tableLH.length(tbIn) < 1 then
      return
   end

   local keysToDelete = this.find_keys_with_duplicate_values(tbIn);
   if tableLH.length(keysToDelete) < 1 then
      return
   end

   for k,_ in pairs(keysToDelete) do
      tbIn[k] = nil
   end
end


function this.find_keys_with_duplicate_values(tbIn)
   local valuesFound = {}
   local keysToDelete = {}
   for k, v in pairs(tbIn) do
      if valuesFound[v] then
         keysToDelete[k] = true;
      else
         valuesFound[v] = true;
      end
   end
   return keysToDelete
end


function this.length(T)
   if not T then
      return 0
   end

   local count = 0
   for _ in pairs(T) do
     count = count + 1
   end
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


-- Shallow copy of table
function this.shallow_copy(t1)
   return {table.unpack(t1)}
end


-- Simple table comparison
-- https://stackoverflow.com/questions/20325332/how-to-check-if-two-tablesobjects-have-the-same-value-in-lua
function this.equal(o1, o2)
    if o1 == o2 then return true end

    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then return false end
    if o1Type ~= 'table' then return false end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or this.equal(value1, value2) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end


return this
