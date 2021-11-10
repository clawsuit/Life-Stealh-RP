function startStopServer()
	--Load the rest
	for i,resource in ipairs(getResources()) do
		local autostart = getResourceInfo(resource, "autostart")
		if (autostart == "true") then
			if eventName == 'onResourceStart' then
				startResource(resource, true)
			else
				stopResource(resource)
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, startStopServer)
addEventHandler("onResourceStop", resourceRoot, startStopServer)



