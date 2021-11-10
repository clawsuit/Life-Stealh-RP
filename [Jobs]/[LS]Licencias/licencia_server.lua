loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local tabla = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in pairs(pickups_infos) do
		tabla[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 255, 255, 255, 0)
		tabla[i]:setInterior(v.int)
		tabla[i]:setDimension(v.dim)
	end
end)

addCommandHandler("licencias", function(p)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			for i, v in ipairs(tabla) do
				if p:isWithinMarker(v) then
					p:triggerEvent("setPanelLicencieros", p)
				end
			end
		end
	end
end)

-- mision
addEvent("startMisionsLicenses", true)
function startMisionsLicenses(t, money)
	if source:getMoney() >= tonumber(money) then
		if t == "Conducir" then
			if source:getData("Roleplay:Licencia_Conducir") == 1 then
				source:outputChat("* Ya tienes una licencia de conducir", 150, 50, 50, true)
			else
				source:setData("Roleplay:Mision", "Licencia")
				source:triggerEvent("IniciarRutaLicencia", source, "Conducir")
				source:outputChat("Tienes 20 segundos para subir a tu vehículo o pierdas la misión.", 150, 50, 50, true)
				source:triggerEvent("callCinematic", source, "Subete a un #FF0033Manana", 5000, "No")
				source:takeMoney( tonumber(money))
			end
		elseif t == "Navegar" then
			if source:getData("Roleplay:Licencia_Navegar") == 1 then
				source:outputChat("* Ya tienes una licencia de navegar", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Navegar", source:getData("Roleplay:Licencia_Navegar") + 1)
			end
		elseif t == "Piloto" then
			if source:getData("Roleplay:Licencia_Piloto") == 1 then
				source:outputChat("* Ya tienes una licencia de piloto", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Piloto", source:getData("Roleplay:Licencia_Piloto") + 1)
			end
		elseif t == "Pesca" then
			if source:getData("Roleplay:Licencia_Pesca") == 1 then
				source:outputChat("* Ya tienes una licencia de pesca", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Pesca", source:getData("Roleplay:Licencia_Pesca") + 1)
			end
		end
	else
		source:outputChat("No tienes el dinero suficiente para comprar esta Licencia.", 150, 50, 50, true)
	end
end
addEventHandler("startMisionsLicenses", root, startMisionsLicenses)

function ObtenerLicencia()
	source:setData("Roleplay:Mision", "")
	source:setData("Roleplay:Licencia_Conducir", source:getData("Roleplay:Licencia_Conducir") + 1)
	if source:isInVehicle() then
		setTimer(function(source)
			if isElement(source) then
				source:removeFromVehicle(source:getOccupiedVehicle())
			end
		end, 1000, 1, source)
	end
	source:outputChat("* Acabas de obtener tu licencia de conducir.", 50, 150, 50, true)
end
addEvent("ObtenerLicencia", true)
addEventHandler("ObtenerLicencia", root, ObtenerLicencia)

addEvent("remo", true)
addEventHandler("remo", root, function()
	source:removeFromVehicle(source:getOccupiedVehicle())
end)