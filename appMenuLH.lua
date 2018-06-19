local this = {}
appMenuLH = this

require("appsLH")
require("uiLH")

----------------------------------
-- Process menu for an app
function this.app_menu(appName)
   local app = appsLH.app_from_name(appName)
   if not app then
      -- print("App " .. appName .. " not found")
      return
   end
   local appMenu = app.menu
   if not appMenu then
      hs.alert("App " .. appName .. " does not have menu")
      return
   end
   -- Cannot switch focus here or chooser never shows up
   -- hs.application.launchOrFocus(appName)
   -- print("inspecting appMenu")
   -- hs.inspect(appMenu)
   this.process_menu(appMenu, appName)
end

function this.current_app_menu()
   local appName = appsLH.current_app_name()
   this.app_menu(appName)
end


--------------------------------------
-- Choose from potentially nested menu
--[[
A menu is a table with multiple entries
Each entry is either another menu or a menu selection
Each key is an option to choose in chooser
A menu selection is a function that can be executed directly
]]

-- This is the main function called,
-- but it is also called recursively from the chooser
-- IN: choiceTb with keys and commands to execute
function this.process_menu(choiceTb, appName)
   assert(type(choiceTb) == "table")
   -- hs.inspect(choiceTb)
   local chooserTb = uiLH.table_for_chooser(choiceTb)
   assert(type(chooserTb) == "table")
   -- hs.inspect(chooserTb)
   local chooser = uiLH.generic_chooser(
      function(choice)
         this.process_menu_selection(choice, choiceTb, appName)
      end,
      chooserTb)
end

-- Process a selection
--[[
IN:
   choice  ::  table
      either another menu or a menu selection
      "text" field contains the key for choiceTb
   choiceTb  ::  table
      maps keys into choices to execute (menus or menu choices)
]]
function this.process_menu_selection(choice, choiceTb, appName)
   if not choice then
      -- User hit escape
      return
   end
   local command = choiceTb[choice.text]
   if this.is_menu(command) then
      this.process_menu(command, appName)
   elseif this.is_menu_choice(command) then
      hs.application.launchOrFocus(appName)
      command()
   else
      hs.inspect(choice)
      error("Input should be menu or menu choice")
   end
end

function this.is_menu(command)
   return type(command) == "table"
end

function this.is_menu_choice(command)
   return type(command) == "function"
end

-- function this.process_menu_choice(command)
--    command()
-- end


return this
