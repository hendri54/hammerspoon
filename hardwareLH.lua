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


-- Volume

function this.volume_adjust(adjAmount)
   local audio = hs.audiodevice.defaultOutputDevice();
   if not audio then
      hs.alert.show('No audio device found')
      return
   end

   local currVol = math.floor(audio:outputVolume() + 0.5);
   local newVol = math.min(math.max(0, currVol + adjAmount), 100);
   audio:setOutputVolume(newVol);
   hs.alert.show('Volume: ' .. newVol);
end

function this.volume_up()
   this.volume_adjust(10)
end

function this.volume_down()
   this.volume_adjust(-10)
end


return this
