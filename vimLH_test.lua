local this = {}
vimLH_test = this

packageLH.reload('vimLH');

function this.test_all()
   this.add_modifier_test()
end

function this.add_modifier_test()
   assert(tableLH.equal(vimLH.add_modifier({}, 'ctrl'),  {'ctrl'}))
   assert(tableLH.equal(vimLH.add_modifier({'shift'}, 'ctrl'),  {'shift', 'ctrl'}))
end

return this
