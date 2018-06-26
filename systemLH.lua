local this = {}
systemLH = this


function this.sleep(n)
  os.execute("sleep " .. tonumber(n))
end

function this.open_with_default_app(filePath)
   os.execute("open " .. filePath)
end

return this
