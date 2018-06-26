local this = {}
uiLH = this

require("startupLH")
require("appsLH")
require("uncVpnLH")



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
Cannot call window manipulation from chooser b/c the frontmost window is not the calling app
]]
function this.replacement_table()
   local t = {OfficeStartup = startupLH.office_startup,
      HomeStartup = startupLH.home_startup,
      HammerspoonConsole = function()  hs.openConsole(true)  end,
      CiscoAnyConnect = uncVpnLH.start_vpn};
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
