local this = {}
hardwareLH = this

function this.brightness_adjust(adjAmount)
   local b = hs.brightness.get()
   b = math.min(b + adjAmount, 100)
   hs.brightness.set(b)
   hs.alert("Brightness " .. b)
end

function this.brightness_up()
   this.brightness_adjust(10)
end

function this.brightness_down()
   this.brightness_adjust(-10)
end

return this
