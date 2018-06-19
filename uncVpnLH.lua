local this = {}
uncVpnLH = this

require("privateLH")
require("systemLH")

this.appName = "Cisco AnyConnect Secure Mobility Client";

function this.launch()
   local launched = hs.application.launchOrFocus(this.appName)
   assert(launched)
end

function this.start_vpn()
   this.launch()
   hs.eventtap.keyStroke({}, "return")
   systemLH.sleep(3)
   hs.eventtap.keyStrokes("privateLH.onyen");
   hs.eventtap.keyStroke({}, "tab");
   hs.eventtap.keyStrokes("push")
end

return this
