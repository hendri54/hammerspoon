local this = {}
constLH = this

require("privateLH")


-- Define constants for key bindings

this.leftKey = "j";
this.rightKey = "k";
this.downKey = "n";
this.upKey = "u";
this.pageUpKey = "p"
this.pageDownKey = "m"
this.wordRightKey = "l";
this.wordLeftKey = "h";
this.startOfLineKey = 'a'
this.endOfLineKey = ';';
this.startOfDocKey = 't';
this.endOfDocKey = 'b';
this.newLineBelowKey = 'o';
this.newLineAboveKey = 'o';  -- shift
this.selectLineKey = 'y';
this.deleteKey = "d";



function this.constant(constName)
   return privateLH.constTable[constName]
end


return this
