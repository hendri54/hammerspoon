local this = {}
packageLH = this


function this.reload(pkName)
	package.loaded[pkName] = nil
	require(pkName)
end



return this
