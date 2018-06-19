local this = {}
constLH = this

require("privateLH")


function this.constant(constName)
   return privateLH.constTable[constName]
end


return this
