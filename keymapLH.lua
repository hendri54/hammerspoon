local this = {}
keymapLH = this

require("textReplaceLH")
require("uiLH")
require("hardwareLH")
require("appMenuLH")

function this.map_keys()
   -- hs.hotkey.bind({"alt", "ctrl"}, 't', test1)

   hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
     hs.reload()
     hs.alert("Config reloaded")
   end)

   if uiLH then
   	hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", uiLH.macro_selector)
      hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", appMenuLH.current_app_menu)
   end

   if textReplaceLH then
   	hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", textReplaceLH.chooser)
   end

   hs.hotkey.bind({"cmd", "alt", "ctrl"}, "=", hardwareLH.brightness_up)
   hs.hotkey.bind({"cmd", "alt", "ctrl"}, "-", hardwareLH.brightness_down)

   hs.hints.style = "vimperator"
   hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'w',
    	function() hs.hints.windowHints() end)

   -- Hotkey for window positioning
   local winPosKey = {"alt", "cmd"}
   hs.hotkey.bind(winPosKey, "a", appsLH.position_all_apps);
   hs.hotkey.bind(winPosKey, "c", appsLH.position_current_app);

   hs.hotkey.bind(winPosKey, "l", window_right_half);
   hs.hotkey.bind(winPosKey, "k", window_right);
   hs.hotkey.bind(winPosKey, ";", window_grow_right);
   hs.hotkey.bind(winPosKey, "o", window_shrink_right);

   hs.hotkey.bind(winPosKey, "h", window_left_half);
   hs.hotkey.bind(winPosKey, "j", window_left);
   hs.hotkey.bind(winPosKey, "g", window_grow_left);
   hs.hotkey.bind(winPosKey, "i", window_shrink_left);

   hs.hotkey.bind(winPosKey, "n", move_win_to_next_screen);
   hs.hotkey.bind(winPosKey, "m", mouse_to_win_center);
end

return this
