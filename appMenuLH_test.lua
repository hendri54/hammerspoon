local this = {}
appMenuLH_test = this


function this.test_all()
   return
end


-----------  Interactive tests

function this.process_menu_test()
   local appName = "TextEdit"
   -- Set up test menu
   local choiceTb = {Save = function() print("Save selected") end,
      Open = function() print("Open selected") end}
   uiLH.process_menu(choiceTb, appName)
end

function this.process_menu_nested_test()
   local appName = "TextEdit"
   -- Set up test menu
   local choiceTb2 = {Save = function() print("Save selected") end,
      Open = function() print("Open selected") end}
   local choiceTb = {Print = function() print("Print selected") end,
      Submenu = choiceTb2}
   uiLH.process_menu(choiceTb, appName)
end


return this
