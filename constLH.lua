local this = {}
constLH = this

require("privateLH")

this.constTable = {
      Onyen = privateLH.onyen,
      gmail = "hendricks.lutz@gmail.com",
      gmailMargarita = "hendricks.mm@gmail.com",
      protonmail = "hendricksl@protonmail.com",
      LutzHendricks = "Lutz Hendricks",
      LutzPhone = "919-886-6885"
   }


function this.constant(constName)
   return this.constTable[constName]
end


-- Template for apps
--[[
Since there is no usable OOP, this is my way of creating inheritance
]]
function this.default_app()
	local app = {}
	app.replaceTb = function()  return nil; end;
	app.useGlobalReplaceTb = true
	app.monitorPos = "main";
	app.menu = nil
	return app
end


return this
