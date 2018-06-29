local this = {}
keymapLH = this

require("textReplaceLH")
require("uiLH")
require("hardwareLH")
require("appMenuLH")
require("displaysLH")

this.chooserMods = {"cmd", "alt", "ctrl"};
this.winPosMods = {"alt", "cmd"};

this.fileChooserKey = 'o';


-- Wrapper for binding keys with key repeat
function bind_key(mods, key, bind_function, withRepeat)
   if withRepeat then
      hs.hotkey.bind(mods, key, bind_function, nil, bind_function)
   else
      hs.hotkey.bind(mods, key, bind_function)
   end
end


function this.map_keys()
   -- hs.hotkey.bind({"alt", "ctrl"}, 't', test1)

   this.map_choosers();
   this.map_window_movements();

   hs.hotkey.bind(this.chooserMods, "R", function()
     hs.reload()
     hs.alert("Config reloaded")
   end)

   local hardwareMods = {"cmd", "alt", "ctrl"};
   bind_key(hardwareMods, "=", hardwareLH.brightness_up, false)
   bind_key(hardwareMods, "-", hardwareLH.brightness_down, false)
   bind_key(hardwareMods, "0", hardwareLH.volume_up, false)
   bind_key(hardwareMods, "9", hardwareLH.volume_down, false)

   hs.hints.style = "vimperator"
   hs.hotkey.bind(this.chooserMods, 'w',
    	function() hs.hints.windowHints() end)
end


function this.map_window_movements()
   -- Hotkey for window positioning
   local winPosKey = this.winPosMods;
   hs.hotkey.bind(winPosKey, "a", appsLH.position_all_apps);
   hs.hotkey.bind(winPosKey, "c", appsLH.position_current_app);

   hs.hotkey.bind(winPosKey, "l", windowLH.window_right_half);
   hs.hotkey.bind(winPosKey, "k", windowLH.window_right);
   hs.hotkey.bind(winPosKey, ";", windowLH.window_grow_right);
   hs.hotkey.bind(winPosKey, "o", windowLH.window_shrink_right);

   hs.hotkey.bind(winPosKey, "h", windowLH.window_left_half);
   hs.hotkey.bind(winPosKey, "j", windowLH.window_left);
   hs.hotkey.bind(winPosKey, "g", windowLH.window_grow_left);
   hs.hotkey.bind(winPosKey, "i", windowLH.window_shrink_left);

   hs.hotkey.bind(winPosKey, "q", windowLH.move_left);
   hs.hotkey.bind(winPosKey, "w", windowLH.move_right);

   hs.hotkey.bind(winPosKey, "n", displaysLH.move_win_to_next_screen);
   hs.hotkey.bind(winPosKey, "m", mouse_to_win_center);
end


function this.map_choosers()
   if fileChooserLH then
      hs.hotkey.bind(this.chooserMods, this.fileChooserKey, fileChooserLH.chooser)
   end

   if uiLH then
   	hs.hotkey.bind(this.chooserMods, "U", uiLH.macro_selector)
   end

   if appMenuLH then
      hs.hotkey.bind(this.chooserMods, "M", appMenuLH.current_app_menu)
   end

   if textReplaceLH then
   	hs.hotkey.bind(this.chooserMods, "Y", textReplaceLH.chooser)
   end

   hs.hotkey.bind(this.chooserMods, "H", hsLH.command_history_chooser)
end

return this
