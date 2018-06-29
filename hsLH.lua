local this = {}
hsLH = this

function this.config()
   -- Disable window animations
   hs.window.animationDuration = 0

   this.console_config();
end

function this.console_config()
   hs.console.darkMode(true)
   hs.console.consoleFont({["name"] = "Menlo", ["size"] = 18})
   hs.console.windowBackgroundColor({white = 0.15, alpha = 0.9})
   hs.console.outputBackgroundColor({white = 0.12, alpha = 1})
   hs.console.inputBackgroundColor({white = 0.12, alpha = 1})
   hs.console.consoleCommandColor({white = 0.8, alpha = 1})
   hs.console.consolePrintColor({red = 0.5, green = 0.3, blue = 1, alpha = 1})
   hs.console.consoleResultColor({red = 0.9, green = 0.4, blue = 0.5, alpha = 1})
end


-- Command history chooser
function this.command_history_chooser()
   local choiceTb = this.make_history_into_chooser_tb();
   local chooser = uiLH.generic_chooser(this.command_history_callback, choiceTb)
end


-- Callback
function this.command_history_callback(choice)
   if not choice then return end
   hs.pasteboard.setContents(choice.text)
   hs.openConsole(true)
   hs.application.launchOrFocus('Hammerspoon')
   hs.eventtap.keyStroke({'cmd'}, 'v')
end


function this.make_history_into_chooser_tb()
   local histTb = hs.console.getHistory();
   if not histTb then return end;
   if tableLH.length(histTb) < 1 then return end;

   -- Table with values already found. To avoid duplicates
   local valueTb = {}
   local chooserTb = {}
   for k, v in pairs(histTb) do
      if not valueTb[v] then
         table.insert(chooserTb, {['text'] = v});
         valueTb[v] = true;
      end
   end
   return chooserTb;
end


---------------------------------
-- Keystrokes with fast repeat
-- https://stackoverflow.com/questions/40986242/key-repeats-are-delayed-in-my-hammerspoon-script
local function fastKeyStroke(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

-- Bind keystroke with fast repeat
function this.fastKeyBind(mods, key,  newMods, newKey)
   hs.hotkey.bind(mods, key,
      function() fastKeyStroke(newMods, newKey) end,
      nil,
      function() fastKeyStroke(newMods, newKey) end
    )
end


return this
