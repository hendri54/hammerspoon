local this = {}
uiLH = this

require("startupLH")
require("appsLH")
require("uncVpnLH")


-------------------------------------------
-- Choose from a list with single keystroke
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


---------------------------------------------
-- Generic chooser
-- Functions in modules cannot see globals
-- The chooser also does not wait for the user's choice
-- Therefore, it cannot return the choice
function this.generic_chooser(choiceFct, choiceTb)
   -- this.genericChooserChoice = nil
   local chooser = hs.chooser.new(choiceFct)
	chooser:bgDark(true)
	chooser:choices(choiceTb)
   chooser:searchSubText(true)
	chooser:show()
end


-- Make the keys of a table into a choice table that a chooser can handle
function this.table_for_chooser(tbIn)
   local choiceTb = {}
   for k, v in pairs(tbIn) do
      table.insert(choiceTb, {["text"] = k})
   end
   return choiceTb
end


-----------------------------------------
-- Execute macros via chooser
function this.macro_selector()
   local choiceTb = this.table_for_chooser(this.replacement_table())
   this.generic_chooser(this.macro_selector_processor,
      choiceTb)
end


-- Build the replacement table
--[[
Keys becomes prompts
Values are functions to execute
]]
function this.replacement_table()
   local t = {OfficeStartup = startupLH.office_startup,
      HomeStartup = startupLH.home_startup,
      HammerspoonConsole = function()  hs.openConsole(true)  end,
      CiscoAnyConnect = uncVpnLH.start_vpn,
      Test = this.replace_test}
   return t
end

-- Function for testing replacement table
function this.replace_test()
   hs.alert("Replace test was selected")
end


-- Executes macros. Processor for macro_selector
function this.macro_selector_processor(in1)
	if not in1 then
		return
	end
   local macroName = in1.text
   local replaceTb = this.replacement_table()
   local command = replaceTb[macroName]

   -- print("macroName = " .. macroName)
   -- print(type(command))

   if type(command) == "function" then
      command()
	else
		hs.alert(macroName .. " was selected")
	end
end

function test_alert()
   hs.alert("Test")
end

return this
