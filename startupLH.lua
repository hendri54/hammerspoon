local this = {}
startupLH = this

function this.home_startup()
	hs.wifi.setPower(true)
	hs.audiodevice.defaultOutputDevice():setVolume(40)
	hs.application.open("com.culturedcode.thingsmac")
	appsLH.start_app("Postbox")
	appsLH.start_app("Path Finder")
	appsLH.position_all_apps()
end

function this.office_startup()
	hs.wifi.setPower(false)
	hs.audiodevice.defaultOutputDevice():setVolume(40)
	hs.application.open("com.culturedcode.thingsmac")
	appsLH.start_app("Postbox")
	appsLH.start_app("Path Finder")
	appsLH.position_all_apps()
end

return this
