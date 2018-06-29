local this = {}
vimLH = this

require('cursorMoveLH');

normal = hs.hotkey.modal.new()
delMode = hs.hotkey.modal.new()


-- functions to bind keys in each mode
function norm_bind(mods, key, bindFct)
   normal:bind(mods, key, nil, bindFct, nil, bindFct);
end

function del_bind(mods, key, bindFct)
   delMode:bind(mods, key, nil, bindFct, nil, bindFct);
end


---------------------------------------------------
-- Mode switching

function normal_enter()
   delMode:exit()
   normal:enter()
   -- hs.alert.show('Normal mode')
   this.mode_show('N')
end

function insert_enter()
    normal:exit()
    delMode:exit()
    -- hs.alert.show('Insert mode')
    this.mode_show('I')
end

function delMode_enter()
   normal:exit()
   delMode:enter()
   -- hs.alert.show('Delete mode')
   this.mode_show('D')
end


-- Menu bar indicating mode
this.modeIndicator = hs.menubar.new(true);

function this.mode_show(modeStr)
   local modeColor = nil;

   if modeStr == 'I' then
      modeColor = hs.drawing.color.green;
   elseif modeStr == 'N' then
      modeColor = hs.drawing.color.blue;
   elseif modeStr == 'D' then
      modeColor = hs.drawing.color.red;
   end
   local t = hs.styledtext.new(modeStr, {font = {name = 'Menlo', size = 16}, color = modeColor});
   this.modeIndicator:setTitle(t);
end



-- Switch modes

enterNormal = hs.hotkey.bind({"cmd"}, "e", normal_enter)
enterDelMode = hs.hotkey.bind({"cmd"}, "d", delMode_enter)
norm_bind({}, 'i', insert_enter)
norm_bind({"cmd"}, 'i', insert_enter)
norm_bind({"cmd"}, "d", delMode_enter)
delMode:bind({"cmd"}, "e", normal_enter);
delMode:bind({}, "i", insert_enter);
delMode:bind({"cmd"}, 'i', insert_enter)


---------------------------------------
-- Bind a key combination in all modes
--[[
IN:
   mods  ::  table
      modifier table
   key  ::  string
      single key
   newMods  ::  table
      new modifiers to be issued
   newKey  ::  string
      single new keystroke to be issued
   bindShift  ::  boolean
      also bind the same key with shift to the same new key also with shift?
   bindControl ::  boolean
      also bind ctrl+key to same key in insert mode
      example: ctrl+j -> left arrow
]]
function this.key_bind(mods, key,  newMods, newKey,  bindShift, bindDelete, bindControl)
   function normalEvent()
      hs.eventtap.keyStroke(newMods, newKey)
   end
   norm_bind(mods, key, normalEvent);

   if bindControl then
      this.key_bind_control(mods, key, newMods, newKey);
   end

   if bindShift then
      this.key_bind_shift(mods, key, newMods, newKey)
   end

   if bindDelete then
      this.key_bind_delete(mods, key, newMods, newKey)
   end
end


-- Key binding in insert mode, but with additional control modifier key
-- Maps ctrl + j into left arrow
function this.key_bind_control(mods, key, newMods, newKey)
   local mods2 = this.add_modifier(mods, "ctrl");
   function ctrlEvent()
      hs.eventtap.keyStroke(newMods, newKey)
   end
   -- Use fast key repeat
   hsLH.fastKeyBind(mods2, key,  newMods, newKey);
   -- hs.hotkey.bind(mods2, key, ctrlEvent, nil, ctrlEvent);
end



-- Same key binding in normal mode, but with additional shift modifier key
function this.key_bind_shift(mods, key, newMods, newKey)
   local mods2 = this.add_modifier(mods, "shift");
   local newMods2 = this.add_modifier(newMods, "shift");
   function shiftEvent()
      hs.eventtap.keyStroke(newMods2, newKey)
   end
   norm_bind(mods2, key, shiftEvent);
end


-- Same key binding in delete mode. Just adds delete key at the end
function this.key_bind_delete(mods, key, newMods, newKey)
   function deleteEvent()
      local newMods2 = this.add_modifier(newMods, "shift");
      hs.eventtap.keyStroke(newMods2, newKey);
      hs.eventtap.keyStroke({}, "delete");
   end
   delMode:bind(mods, key, nil, deleteEvent, nil, deleteEvent);
end


-- Add modifier to modifier table
-- Copies mods table
function this.add_modifier(mods, newMod)
   local mods2 = tableLH.shallow_copy(mods)
   table.insert(mods2, newMod);
   return mods2;
end


---------------------------------------------
-- Key bindings; in all modes

this.key_bind({}, constLH.leftKey,  {}, "Left",  true,  true, true);
this.key_bind({}, constLH.rightKey,  {}, "Right",  true,  true, true);
this.key_bind({}, constLH.upKey,  {}, "Up",  true,  false, true);
this.key_bind({}, constLH.downKey,  {}, "Down",  true,  false, true);
this.key_bind({}, constLH.wordLeftKey,  {"alt"}, "Left",  true,  true, true);
this.key_bind({}, constLH.wordRightKey,  {"alt"}, "Right",  true,  true, true);
this.key_bind({}, constLH.startOfLineKey,  {"cmd"}, "Left",  true,  true, true);
this.key_bind({}, constLH.endOfLineKey,  {"cmd"}, "Right",  true,  true, true);
this.key_bind({}, constLH.startOfDocKey,  {"cmd"}, "Up",  true,  false, false);
this.key_bind({}, constLH.endOfDocKey,  {"cmd"}, "Down",  true,  false, false);
this.key_bind({}, constLH.pageUpKey,  {}, "pageup",  true,  false, false);
this.key_bind({}, constLH.pageDownKey,  {}, "pagedown",  true,  false, false);

hs.hotkey.bind({'ctrl'}, constLH.selectLineKey, cursorMoveLH.select_line);
norm_bind({}, constLH.selectLineKey, cursorMoveLH.select_line);
del_bind({}, constLH.selectLineKey, cursorMoveLH.select_line);

-- delete character after the cursor
local function fndelete()
    hs.eventtap.keyStroke({}, "Right")
    hs.eventtap.keyStroke({}, "delete")
end
normal:bind({}, constLH.deleteKey, fndelete, nil, fndelete)


-- o - open new line below cursor
   -- modify +++
normal:bind({}, constLH.newLineBelowKey, nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        hs.eventtap.keyStroke({"cmd"}, "o")
    else
        hs.eventtap.keyStroke({"cmd"}, "Right")
        normal:exit()
        hs.eventtap.keyStroke({}, "Return")
        hs.alert.show('Insert mode')
    end
end)


-- O - open new line above cursor {{{3
normal:bind({"shift"}, constLH.newLineBelowKey, nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        hs.eventtap.keyStroke({"cmd", "shift"}, "o")
    else
        hs.eventtap.keyStroke({"cmd"}, "Left")
        normal:exit()
        hs.eventtap.keyStroke({}, "Return")
        hs.eventtap.keyStroke({}, "Up")
        hs.alert.show('Insert mode')
    end
end)



return this
