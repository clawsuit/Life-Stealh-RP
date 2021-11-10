loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')

import('*'):init('[LS]Tiendas')

import('*'):init('[LS]NewData')





permisos = {

["Administrador"]=true,

}



local CinturonSeguridad = {}



addEventHandler("onVehicleStartExit", getRootElement(), function(thePlayer, seat)

	if CinturonSeguridad[thePlayer] then

		if CinturonSeguridad[thePlayer] == true then

			MensajeRol(thePlayer, " se desabrocha el cinturon de seguridad.")

			CinturonSeguridad[thePlayer] = nil

		end

	end

end)

--

addEventHandler("onVehicleDamage", getRootElement(), function(loss)

	local thePlayer = source:getOccupant()

	if (thePlayer) then

		local dmg = math.floor(loss)

		if dmg >= 100 then

			if CinturonSeguridad[thePlayer] then

				if CinturonSeguridad[thePlayer] == true then

					thePlayer:outputChat("El vehículo acaba de sufrir un fuerte choque..", 150, 50, 50)

					thePlayer:outputChat("Como llevas el cinturon de seguridad no sufriste daños.", 50, 150, 50)

				end

			else

				thePlayer:outputChat("El vehículo acaba de sufrir un fuerte choque..", 150, 50, 50)

				thePlayer:outputChat("Como no llevas el cinturon de seguridad sufriste daños.", 150, 50, 50)

				if thePlayer:getHealth() >= 20 then

					thePlayer:setHealth(thePlayer:getHealth() - math.random(3,8) )

				end

			end

			source:setEngineState (false)

			source:setFrozen(false)

			source:setLightState(0, 1)

			source:setLightState(1, 1)

			source:setData('Motor', 'apagado')

		end

	end

end)

--



addCommandHandler("cinturon", function(thePlayer)

	local veh = thePlayer:getOccupiedVehicle()

	local seat = thePlayer:getOccupiedVehicleSeat()

	if thePlayer:isInVehicle() then

		if veh then 

			if CinturonSeguridad[thePlayer] then

				MensajeRol(thePlayer, " se desabrocha el cinturon de seguridad.")

				CinturonSeguridad[thePlayer] = nil

			else

				MensajeRol(thePlayer, " se abrocha el cinturon de seguridad.")

				CinturonSeguridad[thePlayer] = true

			end

		end

	end

end)



addCommandHandler('localizarveh',

	function(player,_, id)

		if isElement(player) then

			if tonumber(id) then

				local v = getVehicleFromID(player, tonumber(id))

				local x,y,z = getElementPosition( v )

				local zona,ciudad = getZoneName( x,y,z),getZoneName( x,y,z, true)

				local vName = getVehicleName( v )

				exports['[LS]Notificaciones']:setTextNoti(player, "Su "..vName..' se encuentra en '..ciudad..'-'..zona, 227, 114, 1)

				

			else

				local cuenta = player.account.name

				if _AutosCreados[cuenta] then

					for i,v in ipairs(_AutosCreados[cuenta]) do

						local x,y,z = getElementPosition( v )

						local zona,ciudad = getZoneName( x,y,z),getZoneName( x,y,z, true)

						local vName = getVehicleName( v )

						exports['[LS]Notificaciones']:setTextNoti(player, "Su "..vName..' se encuentra en '..ciudad..'-'..zona, 227, 114, 1)

					end

				end

			end

		end

	end

)



addCommandHandler("vehiculos", function(player, _)

	if not notIsGuest(player) then

		if isElement(player) then

			local cuenta = AccountName(player)

			local s = databaseQuery("SELECT * FROM Info_Vehicles where Cuenta = ?", cuenta)

			if not ( type( s ) == "table" and #s == 0 ) or not s then

				for i, v in ipairs(s) do

					player:outputChat("#A44B00Vehiculo: #FFFFFF"..getVehicleNameFromModel(v.Modelo).." #A44B00ID: #FFFFFF"..v.ID.." #A44B00Placa: #FFFFFF"..v.Placa.." #A44B00Kilometraje: #FFFFFF"..v.Kilometraje.."", 255, 255, 255, true)

				end

			end

		end

	end

end)



addCommandHandler('maletero',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = getPlayerNearbyVehicle(player)

			if veh then

				if getElementData(veh, 'Owner') == cuenta then

					if veh:getDoorOpenRatio(1) == 0 then

						player:setAnimation('BD_FIRE', 'wash_up', -1, false, false, false)

						Timer(

							function(player)

								veh:setDoorOpenRatio(1,1)

								player:setAnimation()

							end

						,3000,1,player)

					else

						veh:setDoorOpenRatio(1,0)

					end

				end

			else

				exports['[LS]Notificaciones']:setTextNoti(player, "Debes estar cerca de tu vehiculo para abrir el maletero", 227, 114, 1)

			end

		end

	end

)

-- candado

addCommandHandler("candado",

	function(player)

		if isElement(player) then

			if player:isInVehicle() then

				local cuenta = player.account.name

				local veh = getPlayerNearbyVehicle(player)

				if veh then

					if bicicletas[veh:getModel()] then

						if veh:getData("Owner") == cuenta then

							if veh:getData("CandadoBicicleta") == false then

								veh:setData("CandadoBicicleta", true)

								veh:setFrozen(false)

								player:outputChat("Desbloqueaste la bicicleta con la llave del candado.", 255, 255, 255, true)

								MensajeRol(player, "le saca el candado a su bicicleta.")

							else

								player:outputChat("Bloqueaste la bicicleta con el candado.", 255, 255, 255, true)

								veh:setData("CandadoBicicleta", false)

								veh:setFrozen(true)

								MensajeRol(player, "le coloca el candado a su bicicleta.")

							end

						end

					end

				end

			else

				player:outputChat("Debes estar adentro de un vehiculo y ser el conductor.", 150, 50, 50, true)

			end

		end

	end

)

--



--

local nameWeapon = {

[22]="Pistola 9mm",

[24]="Desert Eagle .44",

[25]="Escopeta Remington",

[33]="Rifle de Caza",

[29]="Subfusil MP5",

[31]="Fusil M4A1",

[30]="AK-47",

}

--

local nameFromIDWeapon = {

["Pistola 9mm"]=22,

["Desert Eagle .44"]=24,

["Escopeta Remington"]=25,

["Rifle de Caza"]=33,

["Subfusil MP5"]=29,

["Fusil M4A1"]=31,

["AK-47"]=30,

}



addCommandHandler('vermaletero',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = getPlayerNearbyVehicle(player)

			if veh then

				if getElementData(veh, 'Owner') == cuenta or getPlayerFaction(player, "Policia") then

					if veh:getDoorOpenRatio(1) == 1 then

						local mensaje = ''

						local male = veh:getData('Maletero')

						for i = 1, male.Slots do

							local array = male.Items[tostring(i)]

							--mensaje = mensaje..' '..item..' | '..quantity..','

							if array[1] == 'Vacio' then

								item2 = "Slot "..i..': '..array[1]

							else

								item2 = "Slot "..i..": "..array[1].." | "..array[2]..""

							end

							player:outputChat(item2, 50, 150, 50, true)

						end

						exports['[LS]Notificaciones']:setTextNoti(player, 'Espacio: '..table.sizeM(male.Items)..'/'..male.Slots, 255, 255, 0)

					else

						exports['[LS]Notificaciones']:setTextNoti(player, "El maletero debe de estar abierto", 227, 114, 1)

					end

				end

			end

		end

	end

)



local weaponsP = {

[22]=true,

[23]=true,

[24]=true,

[25]=true,

[26]=true,

[27]=true,

[28]=true,

[29]=true,

[32]=true,

[30]=true,

[31]=true,

[33]=true,

[34]=true,

[38]=true,

[16]=true,

[17]=true,

[18]=true,

[39]=true,

}

addCommandHandler('metermaletero',

	function(player, _, ...)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = getPlayerNearbyVehicle(player)

			if veh then

				if getElementData(veh, 'Owner') == cuenta then

					if veh:getDoorOpenRatio(1) == 1 then

						local male = veh:getData('Maletero')
						if weaponsP[getPedWeapon(player)] then

							if table.sizeM(male.Items) < male.Slots then

								local muni = ...

								if tonumber(muni) then

									muni = math.floor(math.abs(muni))

									if getPedTotalAmmo( player ) >= tonumber(muni) then


										local slot = getEmptySpace(veh)

										male.Items[slot] = {getNameWeapon(player),tonumber(muni)}


										takeWeapon(player, getPedWeapon(player), muni)

										veh:setData('Maletero', male)
										player:outputChat('Haz metido un arma en el maletero', 255, 255, 0)

									else 

										exports['[LS]Notificaciones']:setTextNoti(player,"No tienes esa cantidad de munición..", 100, 100, 10)

									end

								else

									exports['[LS]Notificaciones']:setTextNoti(player,"Debes poner la cantidad de munición que deseas guardar.", 150, 50, 50)

								end
							else

								exports['[LS]Notificaciones']:setTextNoti(player, 'El maletero esta lleno', 255, 255, 0)

							end

						elseif (...) == 'chaleco' then

							if table.sizeM(male.Items) < male.Slots then
								local armor = player:getArmor() or 0
								if armor > 0 then

									local slot = getEmptySpace(veh)

									male.Items[slot] = {'chaleco',armor}

									veh:setData('Maletero', male)
									player:setArmor(0)

									player:outputChat('Haz guardado tu chaleco en el maletero', 255, 255, 0)

								end
							else

								exports['[LS]Notificaciones']:setTextNoti(player, 'El maletero esta lleno', 255, 255, 0)

							end

						else

							local concat = table.concat({...},' ')

							local itemName = isItemExist(concat)

							if itemName then

								local male = veh:getData('Maletero')

								if table.sizeM(male.Items) < male.Slots then

									local slot = getEmptySpace(veh)

									male.Items[slot] = {itemName,getPlayerItem(player, itemName)}

									veh:setData('Maletero', male)

									setPlayerItem(player, itemName, 0)

									exports['[LS]Notificaciones']:setTextNoti(player, 'A guardado '..itemName:lower()..' en su maletero', 255, 255, 0)


								else

									exports['[LS]Notificaciones']:setTextNoti(player, 'El maletero esta lleno', 255, 255, 0)

								end

							end

						end

					else

						exports['[LS]Notificaciones']:setTextNoti(player, "El maletero debe de estar abierto", 227, 114, 1)

					end

				end

			end

		end

	end

)





addCommandHandler('sacarmaletero',

	function(player, _, item, muni)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = getPlayerNearbyVehicle(player)

			if veh then

				if getElementData(veh, 'Owner') == cuenta then

					if veh:getDoorOpenRatio(1) == 1 then

						local male = veh:getData('Maletero')

						item = tostring(item)

						if table.sizeM(male.Items) > 0 then

							if tonumber(item) and tonumber(item) <= male.Slots and male.Items[item][1] ~= 'Vacio' then

								if table.findWeapon(male.Items[item][1]) then

									if muni then

										muni = math.floor(math.abs(muni))

										local reid, remuni = unpack(male.Items[item])

										if muni <= tonumber(remuni) then

											local resto = tonumber(remuni) - tonumber(muni)

											local id = getIDWeapon(reid)

											giveWeapon( player, id, tonumber(muni), true )

											male.Items[item] = resto == 0 and {'Vacio'} or {reid,resto}

											veh:setData('Maletero', male)
											player:outputChat('Haz sacado un arma del maletero', 255, 255, 0)

										else 

											exports['[LS]Notificaciones']:setTextNoti(player, 'No tienes esa cantidad de munición en el maletero', 150, 50, 50)

										end

									end

								elseif male.Items[item][1] == 'chaleco' then

									local itemName, quantity = unpack(male.Items[item])									

									male.Items[item] = {'Vacio'}
									player:setArmor(quantity)
									veh:setData('Maletero', male)

									player:outputChat('Haz sacado el chaleco del maletero', 255, 255, 0)

								else

									local itemName, quantity = unpack(male.Items[item])									

									setPlayerItem(player, itemName, quantity)

									male.Items[item] = {'Vacio'}

									veh:setData('Maletero', male)

									exports['[LS]Notificaciones']:setTextNoti(player, 'A sacado '..itemName:lower()..' de su maletero', 255, 255, 0)
										
								end

							end

						else

							exports['[LS]Notificaciones']:setTextNoti(player, 'El maletero esta vacio', 255, 255, 0)

						end

					else

						exports['[LS]Notificaciones']:setTextNoti(player, "El maletero debe de estar abierto", 227, 114, 1)

					end

				end

			end

		end

	end

)



addCommandHandler('traerveh',

	function(player, _, ID, vehID)

		if isElement(player) then

			if permisos[getACLFromPlayer(player)] == true then

				local who = type(tonumber(ID)) == 'number' and getPlayerFromPartialNameID(ID) or getPlayerFromName( ID )

				if who then

					local veh = getVehicleFromID(who, vehID)

					if veh and isVehicleEmpty( veh ) then

						local position = player.matrix.position + player.matrix.right * 3

						setElementPosition(veh,position.x,position.y,position.z)

						setElementRotation(veh, getElementRotation(player))

					end

				end

			end

		end

	end

)



addCommandHandler('estacionar',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = player:getOccupiedVehicle()

			if veh and player:isInVehicle() then

				if getElementData(veh, 'Owner') == cuenta then

					veh.frozen = true

					veh:setEngineState(false)

					veh:setLightState(0, 1)

					veh:setLightState(1, 1)

					veh:setData('Motor','apagado')

					MensajeRol(player, " acaba de estacionar su vehículo", 2)

					exports['[LS]Notificaciones']:setTextNoti(player, "Vehiculo estacionado", 227, 114, 1)

				end

			end

		end

	end

)



addCommandHandler('estadoveh',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = player:getOccupiedVehicle()

			if veh and player:isInVehicle() then

				if getElementData(veh, 'Owner') == cuenta then

					exports['[LS]Notificaciones']:setTextNoti(player, "Estado: "..math.ceil(veh:getHealth()/10)..'%', 255, 255, 1)

				end

			end

		end

	end

)

--cambiarasiento

addCommandHandler('cambiarasiento',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = player:getOccupiedVehicle()

			if veh and player:isInVehicle() then

				local copiloto = getVehicleOccupant( veh, 1 )

				local conductor = getVehicleOccupant( veh )

				if copiloto and conductor then

					removePedFromVehicle( conductor )

					removePedFromVehicle( copiloto )

					warpPedIntoVehicle( conductor, veh, 1 )

					warpPedIntoVehicle( copiloto, veh, 0 )

				else

					removePedFromVehicle( player )

					if copiloto then

						warpPedIntoVehicle( player, veh)

					elseif conductor then

						warpPedIntoVehicle( player, veh, 1)

					end

				end	

			end

		end

	end

)



addCommandHandler('venderveh',

	function(vendedor, _, vehID, comprador, precio)

		if isElement(vendedor) then

			if tonumber(vehID) then

				local veh = getVehicleFromID(vendedor, tonumber(vehID))

				local comprador = type(tonumber(comprador)) == 'number' and getPlayerFromPartialNameID(comprador) or getPlayerFromName( comprador )

				if comprador and tonumber(precio) then

					if comprador ~= vendedor then

						if not getDato(vendedor, 'Solicitador de Compra Veh') then

							local posicion = Vector3(vendedor:getPosition()) -- player

							local posicion2 = Vector3(comprador:getPosition()) -- jugador

							local x, y, z = posicion.x, posicion.y, posicion.z -- jugador

							local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player

							if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5

								if comprador:getMoney() >= tonumber(precio) then

									local idd = getLastID(comprador)

									if (not getPlayerVIP(comprador) and idd-1 < 2) or (getPlayerVIP(comprador) == "VIPNormal" and idd-1 < 3) or (getPlayerVIP(comprador) == "VIPPro" and idd-1 < 4 )then

										setDato(comprador, 'Solicitado de Compra Veh', vendedor, true)

										setDato(vendedor, 'Solicitador de Compra Veh', {veh=getVehicleFromID(vendedor, tonumber(vehID)),id=tonumber(vehID),precio=tonumber(precio)})

										comprador:outputChat('A recibido una solitud de venta',255,255,0)

										comprador:outputChat('Vehiculo: '..veh.name..' Precio: '..precio,255,255,0)

										comprador:outputChat('/comprarveh',255,255,0)

										outputDebugString( vendedor.name..' le esta vendiendo un vehiculo a '..comprador.name, 3, 255, 255, 0)

										Timer(

											function(v,c)

												setDato(c, 'Solicitado de Compra Veh', nil)

												setDato(v, 'Solicitador de Compra Veh', nil)

											end

										,5000,1, vendedor, comprador)

									end

								else

									exports['[LS]Notificaciones']:setTextNoti(vendedor, 'Esta persona no tiene dinero suficiente', 255, 0, 1)

								end

							else

								exports['[LS]Notificaciones']:setTextNoti(vendedor, 'El comprador debe estar a tu lado.', 255, 0, 1)

							end

						else

							exports['[LS]Notificaciones']:setTextNoti(vendedor, 'Ya has solitado una venta, espera un momento.', 255, 0, 1)

						end

					end

				end

			end

		end

	end

)



addCommandHandler('comprarveh',

	function(comprador)

		if isElement(comprador) then

			local vendedor = getDato(comprador, 'Solicitado de Compra Veh')

			if isElement(vendedor) then

				local dato = getDato(vendedor, 'Solicitador de Compra Veh')

				if dato and table.getn(dato) == 3 then

					if comprador:getMoney() >= tonumber(dato.precio) then



						local cuentaV = vendedor.account.name

						local cuentaC = comprador.account.name

						local id = getLastID(comprador)

						local Plate = comprador.name:sub(1, comprador.name:find('_')-1)

						

						dato.veh:destroy()



						if table.getn(_AutosCreados[cuentaV]) > 0 then

							table.remove(_AutosCreados[cuentaV], dato.id)

						end

						

						comprador:takeMoney(dato.precio)

						vendedor:giveMoney(dato.precio)

						



						databaseUpdate("UPDATE Info_Vehicles SET Cuenta='"..cuentaC.."', ID='"..id.."', Placa='"..Plate..' '..id.."' WHERE Cuenta='"..cuentaV.."' AND ID ='"..dato.id.."'")

						

						refreshIDVehicleDBFromPlayer(vendedor)

						

						exports['[LS]Notificaciones']:setTextNoti(getPlayersOverArea(comprador, 8), comprador.name..' le compro un vehiculo a '..vendedor.name, 50, 255, 50)

						comprador:outputChat('Le compraste un vehiculo a '..vendedor.name..' por '..dato.precio..'$')

						outputDebugString( comprador.name..' El compro el vehiculo a '..vendedor.name..' por '..dato.precio..'$', 3, 255, 255, 0)

						

						guardarVehiculosJugador(comprador)

						crearVehiculosJugador(comprador)



						setDato(comprador, 'Solicitado de Compra Veh', nil)

						setDato(vendedor, 'Solicitador de Compra Veh', nil)

					else

						exports['[LS]Notificaciones']:setTextNoti(vendedor, 'Esta persona no tiene dinero suficiente', 255, 0, 1)

					end

				end

			end

		end

	end

)



function refreshIDVehicleDBFromPlayer( player )

	if isElement(player) then

		local account = player.account.name

		local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."'")

		if #datos > 0 then

			for k,v in pairs(datos) do

				local id = tonumber(v.ID)

				local id = id > 1 and tostring(id-1) or tostring(1)

				databaseUpdate("UPDATE Info_Vehicles SET ID='"..id.."', Placa='"..player.name:sub(1, player.name:find('_')-1)..' '..id.."' WHERE Cuenta='"..account.."'")

			end

			guardarVehiculosJugador(player)

			crearVehiculosJugador(player)

		end

	end

end



function getVehicleFromID(player, id)

	if isElement(player) then

		local cuenta = player.account.name

		if _AutosCreados[cuenta] then

			if _AutosCreados[cuenta][tonumber(id)] then

				return _AutosCreados[cuenta][tonumber(id)]

			end

		end

	end

	return false;

end









function table.getn(t)

	local size = 0

	for _ in pairs(t) do

		size = size + 1

	end

	return size

end



function table.sizeM(t)

	local size = 0

	for k,v in pairs(t) do

		if v[1] ~= 'Vacio' then

			size = size + 1

		end

	end

	return size

end



function table.find(t, value)

	for i,v in pairs(t) do

		if v == value then

			return i,v

		end

	end

	return false

end





function getPlayersOverArea(player,range)

	local new = {}

	local x, y, z = getElementPosition( player )

	local chatCol = ColShape.Sphere(x, y, z, range)

	new = chatCol:getElementsWithin("player") or {}

	chatCol:destroy()

	return new

end









function getEmptySpace(veh)

	local male = veh:getData('Maletero')

	if male then

		for i=1,male.Slots do

			if male.Items[tostring(i)][1] == 'Vacio' then

				return tostring(i)

			end

		end

	end

	return false

end







function getNameWeapon(player)

	return nameWeapon[tonumber(getPedWeapon(player))]

end



function getIDWeapon(name)

	return nameFromIDWeapon[tostring(name)]

end



function isItemWeaponMaletero(veh, id)

	local male = veh:getData('Maletero')

	for item,quantity in pairs(male.Items) do

		if tonumber(item) then

			if item == tostring(id) then

				return true

			else

				return false

			end

		end

	end

end



function setItemUpdate(veh, i, val)

	local male = veh:getData('Maletero')

	for item,quantity in pairs(male.Items) do

		if tonumber(item) then

			if item == tostring(i) then

				quantity = quantity + val

			end

		end

	end

	return false

end



function table.findWeapon(value)

	for _,v in pairs(nameWeapon) do

		if v == value then

			return true

		end

	end

	return false

end