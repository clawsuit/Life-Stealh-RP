-- SAVE LICENSES

--[[addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)

	if not notIsGuest(source) then

		--conducir

		local nivel = t:getData("PlayerNivel")

		if (nivel) then

			source:setData("PlayerNivel", tonumber(nivel))

		else

			source:setData("PlayerNivel", 1)

		end

		local exp = t:getData("PlayerExp")

		if (exp) then

			source:setData("PlayerExp", tonumber(exp))

		else

			source:setData("PlayerExp", 0)

		end

	end

end)



function quitSaveDay(q, r, e)

	if not notIsGuest( source ) then

		local account = source.account

		if ( account ) then

			local s = source:getData("PlayerExp")

			account:setData("PlayerExp", s)

			--

			local x = source:getData("PlayerNivel")

			account:setData("PlayerNivel", x)

			--

		end

	end--

end

addEvent("onStopResource", true)

addEventHandler("onPlayerQuit", getRootElement(), quitSaveDay)

addEventHandler("onStopResource", getRootElement(), quitSaveDay)



function stopX( )

	for i, v in ipairs( Element.getAllByType("player") ) do

		if not notIsGuest( v ) then

			triggerEvent("onStopResource", v)

		end

	end

end
addEventHandler("onResourceStop", resourceRoot, stopX)
]]

local Guardar = {{'Nivel',1},{'PlayerExp',0},{'Roleplay:bank_money',0},{'Roleplay:tarjeta_credito',0},{'Roleplay:bank_balance',0}}

function GuardarDatos( )

	local cuenta = source.account

	if cuenta then

		for _, dataName in ipairs(Guardar) do
			
			local dato = source:getData(dataName[1])
			if dato then

				cuenta:setData(dataName[1], dato)

			end

		end

	end

end
addEvent('onGuardaDatos', true)
addEventHandler('onGuardaDatos', root, GuardarDatos)
 
function CargarDatos( )

	local cuenta = source.account

	if cuenta then

		for _, dataName in ipairs(Guardar) do
			
			local dato = cuenta:getData(dataName[1])
			if dato then

				source:setData(dataName[1], dato)

			else

				source:setData(dataName[1], dataName[2])

			end

		end
		
	end

end
addEvent('onCargaDatos', true)
addEventHandler('onCargaDatos', root, CargarDatos)



function loginStart()

	if eventName == 'onPlayerLogin' then
		triggerEvent('onCargaDatos', source)
	else
		for _, player in ipairs(Element.getAllByType('player')) do
			triggerEvent('onCargaDatos', player)
		end
	end

end
addEventHandler("onPlayerLogin", getRootElement(), loginStart)
addEventHandler("onResourceStart", getResourceRootElement(), loginStart)


function quitStop()

	if eventName == 'onPlayerQuit' then
		triggerEvent('onGuardaDatos', source)
	else
		for i,player in ipairs(Element.getAllByType('player')) do
			triggerEvent('onGuardaDatos', player)
		end
	end

end
addEventHandler("onPlayerQuit", getRootElement(), quitStop)
addEventHandler("onResourceStop", getResourceRootElement(), quitStop)



--[[setTimer(
	function()

		for i,player in ipairs(Element.getAllByType('player')) do
			
			for _,v in ipairs({{'PlayerNivel',1},{'PlayerExp',0}}) do
				
				if player.account then
					player.account:setData(v[1], v[2])
				end

			end
		end

	end
,5000,1)]]