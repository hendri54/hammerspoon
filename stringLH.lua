local this = {}
stringLH = this


function this.split(strIn, separator)
   local t = {};
   local i1 = 0;
   for token in string.gmatch(strIn, "[^,]+") do
      i1 = i1 + 1;
      t[i1] = token;
   end
   -- remove leading and trailing spaces +++++
   -- test this +++++
   return t;
end


-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(programming)
function this.trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end


-- Trim all strings in a table
function this.trim_table(tbIn)
   for k,v in pairs(tbIn) do
      if type(v) == 'string' then
         -- Table can be modified as long as no new keys are added
         tbIn[k] = stringLH.trim(v);
      end
   end
end

return this
