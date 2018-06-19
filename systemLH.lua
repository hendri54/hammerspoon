local this = {}
systemLH = this


function this.sleep(n)
  os.execute("sleep " .. tonumber(n))
end


return this
