local this = {}
pathfinderLH = this

require('tagsLH');

this.name = 'Path Finder';


function this.app()
   local app = appDefaultsLH.default_app()
   app.name = this.name;
   app.replaceTb = nil
   app.useGlobalReplaceTb = true
   app.windowPos = windowLH.right;
   app.widthFracSmall = 80;
   app.widthFracLarge = 70;
   app.menu = {TagSelection = this.tag_selection}
   return app
end


function this.is_running()
   if hs.application.find(this.name) then
      return true;
   else
      return false;
   end
end


-- Get table with current selection, if Pathfinder is running
function this.get_selection()
   if not this.is_running() then return end;
   local scriptStr = [[
tell application "Path Finder"
   set thePaths to {}
   repeat with pfItem in (get selection)
      set the end of thePaths to POSIX path of pfItem
   end repeat
   return thePaths
end tell ]];
   success, pathTb = hs.osascript.applescript(scriptStr);
   if success then
      return pathTb;
   else
      return nil;
   end
end


-- add this to application menu +++++

-- Dialog to tag current selection of files
function this.tag_selection()
   local pathTb = this.get_selection()
   if not pathTb then
      hs.alert.show('Pathfinder: nothing to tag')
      return
   end;
   tagsLH.tag_dialog(pathTb, 'Path Finder');
end

return this
