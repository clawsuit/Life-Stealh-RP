-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	if not notIsGuest(source) then
		--conducir
		local conducir = t:getData("Roleplay:ExpJobPizzero")
		if (conducir) then
			local va = t:getData("Roleplay:ExpJobPizzero")
			source:setData("Roleplay:ExpJobPizzero", va)
		else
			source:setData("Roleplay:ExpJobPizzero", 1)
		end
	end
end)

function quitPizzero(q, r, e)
	if not notIsGuest(source) then
		local account = source:getAccount()
		if (account) then
			local va = source:getData("Roleplay:ExpJobPizzero")
			account:setData("Roleplay:ExpJobPizzero", va)
		end
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitPizzero)
addEventHandler("onStopResource", getRootElement(), quitPizzero)

function stopPizzero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopPizzero)