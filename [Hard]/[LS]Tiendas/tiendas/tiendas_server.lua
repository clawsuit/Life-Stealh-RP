buysshop = {
	["24/7"] = {
	{-27.940196990967, -89.615165710449, 1003.546875, int= 18, dim = 0, items={"Telefono", "Agenda", "Cuchillo de Caza (Arma)", "Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua"}},
	{-27.940196990967, -89.615165710449, 1003.546875, int= 18, dim = 1, items={"Telefono", "Agenda", "Cuchillo de Caza (Arma)", "Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua"}},
	{-27.940196990967, -89.615165710449, 1003.546875, int= 18, dim = 3, items={"Telefono", "Agenda", "Cuchillo de Caza (Arma)", "Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua"}},
	{-23.242370605469, -55.641002655029, 1003.546875, int= 6, dim = 2, items={"Telefono", "Agenda", "Cuchillo de Caza (Arma)", "Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua"}},
	{-23.242370605469, -55.641002655029, 1003.546875, int= 6, dim = 1, items={"Telefono", "Agenda", "Cuchillo de Caza (Arma)", "Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua"}},
	{-23.242370605469, -55.641002655029, 1003.546875, int= 6, dim = 0, items={"Telefono", "Agenda", "Cuchillo de Caza (Arma)", "Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua"}},
	--
	{-30.561338424683, -28.993001937866, 1003.5572509766, int= 4, dim = 0, items={"Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua", "Bidon Vacio"}},
	{-30.561338424683, -28.993001937866, 1003.5572509766, int= 4, dim = 1, items={"Lata de Spray", "Caja de Cigarros", "Encendedor", "Camara", "Cerveza", "Agua", "Bidon Vacio"}},
	},
	["Bebidas"] = {
	{-2654.0190429688, 1413.6501464844, 906.27709960938, int= 3, dim = 0, items={"Cerveza", "Agua", "Caja de Cigarros", "Encendedor"}},
	{497.33801269531, -75.859100341797, 998.7578125, int= 11, dim = 0, items={"Cerveza", "Agua", "Caja de Cigarros", "Encendedor"}},
	{499.79028320313, -20.544431686401, 1000.6796875, int= 17, dim = 0, items={"Cerveza", "Agua", "Caja de Cigarros", "Encendedor"}},
	{499.79028320313, -20.544431686401, 1000.6796875, int= 17, dim = 1, items={"Cerveza", "Agua", "Caja de Cigarros", "Encendedor"}},
	{-224.78340148926, 1404.3884277344, 27.7734375, int= 18, dim = 0, items={"Cerveza", "Agua", "Caja de Cigarros", "Encendedor"}},
	},
	["Burger"] = {
	{377.26641845703, -67.437118530273, 1001.5078125, int= 10, dim = 3, items={"Hamburguesa", "Hamburguesa Chica", "Hamburguesa Grande"}},
	{377.26641845703, -67.437118530273, 1001.5078125, int= 10, dim = 2, items={"Hamburguesa", "Hamburguesa Chica", "Hamburguesa Grande"}},
	{377.26641845703, -67.437118530273, 1001.5078125, int= 10, dim = 1, items={"Hamburguesa", "Hamburguesa Chica", "Hamburguesa Grande"}},
	{377.26641845703, -67.437118530273, 1001.5078125, int= 10, dim = 0, items={"Hamburguesa", "Hamburguesa Chica", "Hamburguesa Grande"}},
	},
	["Cluckin' Bell"] = {
	{369.76181030273, -6.0199885368347, 1001.8588867188, int= 9, dim = 0, items={"Pata de Pollo", "Hamb. de Pollo", "Pollo Asado"}},
	{369.76181030273, -6.0199885368347, 1001.8588867188, int= 9, dim = 1, items={"Pata de Pollo", "Hamb. de Pollo", "Pollo Asado"}},
	{369.76181030273, -6.0199885368347, 1001.8588867188, int= 9, dim = 2, items={"Pata de Pollo", "Hamb. de Pollo", "Pollo Asado"}},
	},
	["Pizza"] = {
	{375.72564697266, -118.80428314209, 1001.4995117188, int= 5, dim = 0, items={"Pizzeta", "Pizza Chica", "Pizza Grande"}},
	{375.72564697266, -118.80428314209, 1001.4995117188, int= 5, dim = 1, items={"Pizzeta", "Pizza Chica", "Pizza Grande"}},
	},
	["Restuarante"] ={
	{378.79110717773, -190.54232788086, 1000.6328125, int= 17, dim = 0, items={"Pata de Pollo", "Hamb. de Pollo", "Pollo Asado", "Agua", "Lata de Spray"}},
	{378.79110717773, -190.54232788086, 1000.6328125, int= 17, dim = 1, items={"Pata de Pollo", "Hamb. de Pollo", "Pollo Asado", "Agua", "Lata de Spray"}},
	}
}

addEventHandler("onResourceStart", resourceRoot, function()
	for index, valores in pairs(buysshop) do
		for _, v in ipairs(valores) do
			--
			p = Pickup(v[1], v[2], v[3], 3, 1239, 0 )
			p:setData("pickup.infoshops", index)
			p:setInterior(v.int)
			p:setDimension(v.dim)
			p:setData("pickup.tableinfo", v.items)
			--
			addEventHandler("onPickupHit", p, function(hitElement)
				if hitElement:getType() == "player" then
					if not hitElement:isInVehicle() then
						bindKey ( hitElement, "F", "down", OpenWindowFoods )
						hitElement:setData("PickupData", source)
					end
				end
			end)
			addEventHandler("onPickupLeave", p, function(hitElement)
				if hitElement:getType() == "player" then
					if not hitElement:isInVehicle() then
						unbindKey ( hitElement, "F", "down", OpenWindowFoods )
						hitElement:setData("PickupData", nil)
					end
				end
			end)
		end
	end
end)	

addEvent("BuyItem", true)
addEventHandler("BuyItem", root, function(item, costo)
	if source:getMoney() >= tonumber(costo) then -- or item == "Agenda" or item == "Cámara" or item == "Cuchillo de Caza (Arma)" or item == "Lata de Spray" or item == "Caja de Cigarros" or item == "Encendedor"
		local account = source:getAccount()
		if item == "Telefono" then
			if source:getData("Roleplay:Telefono") == "No" then
				local numero = math.random(50000, 90000)
				outputDebugString('El jugador '..source.name..' Compro ['..item..']', 0, 0, 130, 232 )
				exports['[LS]Notificaciones']:setTextNoti(source,"* ha comprado un Telefono con el Número: #FF0000"..tonumber(numero).."#ffffff por: #009B00$"..costo.." dolares", 255, 255, 255, true)
				source:setData("Roleplay:NumeroTelefono", tonumber(numero))
				account:setData("Roleplay:NumeroTelefono", tonumber(numero))
				source:setData("Roleplay:Telefono", "Si")
				account:setData("Roleplay:Telefono", "Si")
				source:takeMoney(tonumber(costo))--
			else
				exports['[LS]Notificaciones']:setTextNoti(source,"* Ya tienes un telefono..", 150, 0, 0)
			end
		elseif item == "Agenda" then --
			if source:getData("Roleplay:Agenda") == "No" then
				outputDebugString('El jugador '..source.name..' Compro ['..item..']', 0, 0, 130, 232 )
				exports['[LS]Notificaciones']:setTextNoti(source,"* ha comprado una Agenda por: #009B00$"..costo.." dolares", 255, 255, 255, true)
				exports['[LS]Notificaciones']:setTextNoti(source,"/agenda", 0, 150, 0, true)
				source:setData("Roleplay:Agenda", "Si")
				account:setData("Roleplay:Agenda", "Si")
				source:takeMoney(tonumber(costo))
			else
				exports['[LS]Notificaciones']:setTextNoti(source,"* Ya tienes una agenda..", 150, 0, 0)
			end
		elseif item == "Cuchillo de Caza (Arma)" then
			if source:getWeapon() == 4 then
				exports['[LS]Notificaciones']:setTextNoti(source,"* Ya tienes un cuchillo en mano.", 150, 0, 0, true)
			else
				outputDebugString('El jugador '..source.name..' Compro ['..item..']', 0, 0, 130, 232 )
				exports['[LS]Notificaciones']:setTextNoti(source,"* ha comprado un Cuchillo por: #009B00$"..costo.." dolares", 255, 255, 255, true)
				source:giveWeapon(4, 1, true)
				source:takeMoney(tonumber(costo))
			end
		elseif item == "Camara" then
			if source:getWeapon() == 43 then
				exports['[LS]Notificaciones']:setTextNoti(source,"* Ya tienes una camara en mano.", 150, 0, 0, true)
			else
				outputDebugString('El jugador '..source.name..' Compro ['..item..']', 0, 0, 130, 232 )
				exports['[LS]Notificaciones']:setTextNoti(source,"* ha comprado una Camara por: #009B00$"..costo.." dolares", 255, 255, 255, true)
				source:giveWeapon(43, 10, true)
				source:takeMoney(tonumber(costo))
			end
		else
			outputDebugString('El jugador '..source.name..' Compro ['..item..']', 0, 0, 130, 232 )
			if item == "Caja de Cigarros" then
				setPlayerItem(source, item, getPlayerItem(source, item)+20)
			elseif item == "Encendedor" then
				setPlayerItem(source, item, getPlayerItem(source, item)+10)
			else
				setPlayerItem(source, item, getPlayerItem(source, item)+1)
			end
			exports['[LS]Notificaciones']:setTextNoti(source,"* ha comprado un/a #EE0000"..item.." #FFFFFFpor:#009B00 $"..costo.." dolares", 255, 255, 255, true)
			source:takeMoney(tonumber(costo))
		end
	else
		exports['[LS]Notificaciones']:setTextNoti(source,"* No tienes suficiente dinero para comprar un/a "..item.."", 150, 0, 0)
	end
end)

function OpenWindowFoods( source )
	if not source:isInVehicle() then
		local coldat = source:getData("PickupData")
		if isElement( coldat ) then
			local infos = coldat:getData("pickup.tableinfo")
			source:triggerEvent("Comidas:setWindow", source, infos)
		end
		unbindKey(source, "F", "down", OpenWindowFoods)
	end
end