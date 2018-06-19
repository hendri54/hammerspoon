local this = {}
testLH = this

require("packageLH")

function this.test_all()
	this.test_all_packages()
end


function this.test_all_packages()
	local pkgList = {"constLH", "appDefaultsLH", "appsLH", "tableLH", "windowLH",
		"textReplaceLH", "uiLH", "keymapLH", "displaysLH", "appMenuLH"}
	for k, v in pairs(pkgList) do
		this.package_test(v)
	end
end


function this.package_test(pkName)
	print("Testing package " .. pkName)
	packageLH.reload(pkName)
	packageLH.reload(pkName .. "_test")
	pkg = package.loaded[pkName .. "_test"]
	assert(pkg)
	pkg.test_all()
	print("Done")
end


-- Ad hoc testing
function this.test1()
	local k = hs.hotkey.modal.new('cmd-shift', 'b')
	function k:entered()
		hs.alert'Entered mode'
	end
	function k:exited()
		hs.alert'Exited mode'
	end
	k:bind('', 'escape', function() k:exit() end)
	k:bind('', 'J', 'Pressed J',function() print'let the record show that J was pressed' end)
end

function this.test_chooser()
	local chooser = hs.chooser.new(this.test_chooser_processor)
	chooser:bgDark(true)
	local choiceTb = {{["text"] = "Choice one",  ["uuid"] = "one"},
		{["text"] = "Choice two",  ["uuid"] = "two"}}
	chooser:choices(choiceTb)
	chooser:show()
	-- local chosenRow = hs.chooser:selectedRowContents()
	-- print(chosenRow.text)
	-- print(chosenRow.uuid)
end


function this.test_chooser_processor(in1)
	print("Callback function")
	print(in1)
	chosenValue = in1
end



return this
