-- Choose from a list with single keystroke
--[[
Status: not working because I cannot figure out how to capture a single keystroke
]]
local this = {}
oneKeyChooserLH = this


function this.choose_from_list(inputTb)
   alertList = this.show_list(inputTb, 20)
   this.capture_keystroke()
   -- need to wait without blocking cpu +++++
   hs.alert.closeSpecific(alertList)
   print(this.capturedKey)
end


-- Capture next keystroke
-- Result is stored here
this.capturedKey = nil

function this.capture_keystroke()
   this.capturedKey = nil
   local evtType = hs.eventtap.event.types.keyDown
   watcher = hs.eventtap.new({evtType}, this.keystroke_handler)

   -- Stop watcher if no key is pressed within a set time
   -- Cannot set a wait. That prevents the callback from being called
   -- (cpu busy)
   hs.timer.doAfter(8, function()
      watcher:stop()
      end)
   watcher:start()
end

-- Handler
function this.keystroke_handler(evt)
   local localKey = evt:getCharacters();
   this.capturedKey = localKey;
   -- hs.alert("Key " .. this.capturedKey .. " = "  ..  localKey .. " pressed");
   watcher:stop();
   -- gobble up keystroke
   return true
end


-- Show a list in an alert box
--[[
IN:
   inputTb  ::  table
      each element becomes a row
      each entry separated by tabs
]]
function this.show_list(inputTb, duration)
   local showList = ""
   for k, v in pairs(inputTb) do
      showList = showList .. "\n" .. this.make_line_to_show(v)
   end
   return hs.alert(showList, duration)
end

-- Make a table entry into a line to show
function this.make_line_to_show(inputTb)
   local showLine = ""
   for k, v in pairs(inputTb) do
      if showLine ~= "" then
         showLine = showLine .. "\t\t"
      end
      showLine = showLine .. v
   end
   return showLine
end


return this
