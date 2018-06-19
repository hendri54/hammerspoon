local this = {}
consoleLH = this

function this.console_config()
   hs.console.darkMode(true)
   hs.console.consoleFont({["name"] = "Menlo", ["size"] = 18})
   hs.console.windowBackgroundColor({white = 0.15, alpha = 0.9})
   hs.console.outputBackgroundColor({white = 0.1, alpha = 1})
   hs.console.inputBackgroundColor({white = 0.1, alpha = 1})
   hs.console.consoleCommandColor({white = 0.7, alpha = 1})
   hs.console.consolePrintColor({red = 0.3, green = 0.3, blue = 0.7, alpha = 1})
   hs.console.consoleResultColor({red=0.7, green = 0.3, blue = 0.3, alpha = 1})
end

return this
