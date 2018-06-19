local this = {}
textReplaceLH = this

require("privateLH")


-- Replacement table for app
function this.app_table(appName)
   local app = appsLH.app_from_name(string.lower(appName))
   if app then
      return app.replaceTb
   else
      return nil
   end
end


-- Table that joins app and constants
function this.replacement_table(appName)
   local t = privateLH.constTable
   if appName then
      t2 = this.app_table(string.lower(appName))
   end
   if t2 then
      return tableLH.merge(t2, t)
   else
      return t
   end
end


--  Text replacement  ---------------------------------------
--[[
IN:
   macroName
      text to be replaced
   appName
      app name, optional
   typeIt  ::  boolean
      type the replacement?
]]
function this.replace_text(macroName, appName, typeIt)
   local keyStrokes = nil
   -- App specific
   if appName then
      keyStrokes =
         this.app_specific_replace_text(macroName, appName)
   end
   -- All apps
   if not keyStrokes then
      keyStrokes = this.generic_replace_text(macroName)
   end
   -- Process replacement
   if keyStrokes and typeIt then
      -- flickers console on when it is visible
      hs.application.launchOrFocus(appName)
      hs.eventtap.keyStrokes(keyStrokes)
   end
   return keyStrokes
end


-- App specific text replacement
function this.app_specific_replace_text(macroName, appName)
   if not appName then
      return nil
   end
   t = this.app_table(appName)
   if t then
      return t[macroName]
   else
      return nil
   end
end

function this.generic_replace_text(macroName)
   t = privateLH.constTable
   return t[macroName]
end


function this.choice_table(appName)
   local globalTable = uiLH.table_for_chooser(privateLH.constTable)
   local tbIn = this.app_table(string.lower(appName))

   if tbIn then
      local appTable = uiLH.table_for_chooser(tbIn)
      return tableLH.concat(appTable, globalTable)
   else
      return globalTable
   end
end


-- Chooser
function this.chooser()
   local appName = appsLH.current_app_name()
   local choiceTb = this.choice_table(appName)

   print(appName)
   for k,v in pairs(choiceTb) do
      print(v.text)
   end

   local chooser = uiLH.generic_chooser(
      function(in1)  this.chooser_processor(in1, appName)  end,
      choiceTb)
end


-- Processor for chooser that offers text replacements
--[[
IN:
   in1  ::  table
      chosen row (table)
]]
function this.chooser_processor(in1, appName)
	if not in1 then
		return
	end
   local macroName = in1.text

   local keyStrokes = this.replace_text(macroName, appName, true)
end



return this
