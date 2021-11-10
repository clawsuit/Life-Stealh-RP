-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	if not notIsGuest(source) then
		--conducir
		local conducir = t:getData("Roleplay:ExpJobBusetero")
		if (conducir) then
			local va = t:getData("Roleplay:ExpJobBusetero")
			source:setData("Roleplay:ExpJobBusetero", va)
		else
			source:setData("Roleplay:ExpJobBusetero", 1)
		end
	end
end)

function quitBusetero(q, r, e)
	if not notIsGuest(source) then
		local account = source:getAccount()
		if (account) then
			local va = source:getData("Roleplay:ExpJobBusetero")
			account:setData("Roleplay:ExpJobBusetero", va)
		end
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitBusetero)
addEventHandler("onStopResource", getRootElement(), quitBusetero)

function stopBusetero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopBusetero)