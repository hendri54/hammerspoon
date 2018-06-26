-- File chooser
--[[
Purpose: Select files that go with keywords

#todo: have multiple keywords for each file; like tags
]]
local this = {}
fileChooserLH = this;

require('uiLH')
require('systemLH')


-- Replacement table
function this.replacement_table()
   local t = {CollegeDropouts = "/Users/lutz/Dropbox/hc/college/college_dropouts.lyx",
      HExternalities = "/Users/lutz/Dropbox/hc/hc_externalities.lyx"}
   return t
end


-- Chooser
function this.chooser()
   local choiceTb = uiLH.table_for_chooser(this.replacement_table())
   uiLH.generic_chooser(this.callback, choiceTb)
end


-- Callback function
function this.callback(in1)
	if not in1 then
		return
	end
   local macroName = in1.text
   local replaceTb = this.replacement_table()
   local filePath = replaceTb[macroName]

   systemLH.open_with_default_app(filePath);
end


return this
