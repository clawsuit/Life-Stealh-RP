-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	if not notIsGuest(source) then
		--conducir
		local conducir = t:getData("Roleplay:Licencia_Conducir")
		if (conducir) then
			local va = t:getData("Roleplay:Licencia_Conducir")
			source:setData("Roleplay:Licencia_Conducir", va)
		else
			source:setData("Roleplay:Licencia_Conducir", 0)
		end
		--
		local navegar = t:getData("Roleplay:Licencia_Navegar")
		if (navegar) then
			local x = t:getData("Roleplay:Licencia_Navegar")
			source:setData("Roleplay:Licencia_Navegar", x)
		else
			source:setData("Roleplay:Licencia_Navegar", 0)
		end
		--
		local piloto = t:getData("Roleplay:Licencia_Piloto")
		if (piloto) then
			local s = t:getData("Roleplay:Licencia_Piloto")
			source:setData("Roleplay:Licencia_Piloto", s)
		else
			source:setData("Roleplay:Licencia_Piloto", 0)
		end
		--
		local pesca = t:getData("Roleplay:Licencia_Pesca")
		if (pesca) then
			local x = t:getData("Roleplay:Licencia_Pesca")
			source:setData("Roleplay:Licencia_Pesca", x)
		else
			source:setData("Roleplay:Licencia_Pesca", 0)
		end
		--
		local armas = t:getData("Roleplay:Licencia_Arma")
		if (armas) then
			local f = t:getData("Roleplay:Licencia_Arma")
			source:setData("Roleplay:Licencia_Arma", f)
		else
			source:setData("Roleplay:Licencia_Arma", 0)
		end
	end
end)

function quitSaveLicencias(q, r, e)
	if not notIsGuest(source) then
		local account = source:getAccount()
		if (account) then
			local va = source:getData("Roleplay:Licencia_Conducir")
			account:setData("Roleplay:Licencia_Conducir", va)
			--
			local x = source:getData("Roleplay:Licencia_Navegar")
			account:setData("Roleplay:Licencia_Navegar", x)
			--
			local s = source:getData("Roleplay:Licencia_Piloto")
			account:setData("Roleplay:Licencia_Piloto", s)
			--
			local d = source:getData("Roleplay:Licencia_Pesca")
			account:setData("Roleplay:Licencia_Pesca", d)
			--
			local f = source:getData("Roleplay:Licencia_Arma")
			account:setData("Roleplay:Licencia_Arma", f)
		end
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitSaveLicencias)
addEventHandler("onStopResource", getRootElement(), quitSaveLicencias)

function stopX( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopX)