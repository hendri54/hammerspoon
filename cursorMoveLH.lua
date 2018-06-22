local this = {}
cursorMoveLH = this

-- Select entire line
function this.select_line()
   hs.eventtap.keyStroke({"cmd"}, "Left");
   hs.eventtap.keyStroke({"cmd", "shift"}, "Right")
end

-- Delete line
function this.delete_line()
   this.select_line();
   hs.eventtap.keyStroke({}, "delete")
end

return this
