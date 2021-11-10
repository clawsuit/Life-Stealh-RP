loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local MarkersBusetero = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getJobsBusetero()) do
		--
		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		--
		Pickup(v[1], v[2], v[3], 3, 1210, 0)
		MarkersBusetero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)
		MarkersBusetero[i]:setInterior(v.int)
		MarkersBusetero[i]:setDimension(v.dim)
		MarkersBusetero[i]:setData("MarkerJob", "Busetero")
	end
end)

addCommandHandler("trabajar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:getData("Roleplay:trabajo") =="" then
				for i, marker in ipairs(MarkersBusetero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Busetero" then
							if player:getData("Roleplay:trabajo") == "Busetero" then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								player:setData("Roleplay:trabajo", "Busetero")
								player:triggerEvent("iniciarRutaBusetero", player, "LS")
								player:outputChat("¡Bienvenido al trabajo de #ffff00busetero#ffffff!", 255, 255, 255, true)
								player:triggerEvent("callCinematic", player, "Subete a un #FF0033bus", 5000, "No")
								--player:outputChat("Tienes 20 segundos para subir a tu vehículo o pierdas la misión.", 150, 50, 50, true)
							end
						end
					end
				end
			end
		end
	end
end)

addCommandHandler("infopizzero", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			for i, v in ipairs(MarkersBusetero) do
				if player:isWithinMarker(v) then
					local job = v:getData("MarkerJob")
					if job == "Busetero" then
						player:outputChat("¡Bienvenidos al trabajo de #ffff00busetero#ffffff!", 255, 255, 255, true)
					end
				end
			end
		end
	end
end)

addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:getData("Roleplay:trabajo") ~="" then
				for i, v in ipairs(MarkersBusetero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Busetero" then
							if player:getData("Roleplay:trabajo") == "Busetero" then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajo", "")
								player:triggerEvent("failedMissionBus", player)
							else
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
								player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)

addEvent("giveMoneyBusetero", true)
function giveMoneyBusetero()
	local propinarandom = math.random(1,8)
	local exp = source:getData("Roleplay:ExpJobBusetero") or 1
	local totalMoney = math.ceil(math.random(5,15)*exp/0.7)
	--
	local malasuerte = math.random(1,6)
	text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffff por el pasajero."
	source:giveMoney(tonumber(totalMoney))
	source:outputChat(text, 255, 255, 255, true)
end
addEventHandler("giveMoneyBusetero", root, giveMoneyBusetero)

addEvent("giveBuseteroExp", true)
function giveBuseteroExp()
	source:setData("Roleplay:ExpJobBusetero", source:getData("Roleplay:ExpJobBusetero") + 1)
	source:outputChat("Acabas de obtener + "..source:getData("Roleplay:ExpJobBusetero").." de experiencia en el trabajo de #ffff00busetero", 255, 255, 255, true)
end
addEventHandler("giveBuseteroExp", root, giveBuseteroExp)
