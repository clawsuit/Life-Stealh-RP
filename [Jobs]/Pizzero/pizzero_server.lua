loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local MarkersPizzero = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getJobsPizzero()) do
		--
		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		--
		Pickup(v[1], v[2], v[3], 3, 1210, 0)
		MarkersPizzero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)
		MarkersPizzero[i]:setInterior(v.int)
		MarkersPizzero[i]:setDimension(v.dim)
		MarkersPizzero[i]:setData("MarkerJob", "Pizzero")
	end
end)
--
addCommandHandler("trabajar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:getData("Roleplay:trabajo") == "" then
				for i, marker in ipairs(MarkersPizzero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Pizzero" then
							if player:getData("Roleplay:trabajo") == "Pizzero" then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								player:setData("Roleplay:trabajo", "Pizzero")
								--
								player:triggerEvent("IniciarPizzero", player)
								player:setData("PizzeroPedidos", false)
								--
								player:outputChat("¡Bienvenido al trabajo de #ffff00pizzero#ffffff!", 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)
--
addCommandHandler("infopizzero", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			for i, v in ipairs(MarkersPizzero) do
				if player:isWithinMarker(v) then
					local job = v:getData("MarkerJob")
					if job == "Pizzero" then
						player:outputChat("¡Bienvenidos al trabajo de #ffff00pizzero#ffffff!", 255, 255, 255, true)
						player:outputChat("---------", 100, 100, 100, true)
						player:outputChat("Aquí el trabajo consiste en que debes subir a tu moto, aquí en la espalda del trabajo donde te encuentras, estará el marcador donde podrás obtener ...", 255, 255, 255, true)
						player:outputChat("los pedidos de las personas, recuerda que debes poner #00ff00/obtenerpedidos#ffffff para poder recién trabajar, luego te debes dirigir al lugar donde te indicará con un blip en el mini map o también en el radar.", 255, 255, 255, true)
						player:outputChat("Luego debes bajarte de la moto pasar por el marcador, luego ganaras dinero de la entrega o también propinas (Quizás depende de la entrega obtendras una experiencia del trabajo)", 255, 255, 255, true)
						player:outputChat("Mientras más experiencia tengas en el trabajo aumenta mas la paga de las entregas.", 150, 150, 50, true)
						player:outputChat("---------", 100, 100, 100, true)
						player:outputChat("Si deseas limpiar el chat usa el comando #FF0033/cc", 150, 50, 50, true)
					end
				end
			end
		end
	end
end)
--
addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:getData("Roleplay:trabajo") ~="" then
				for i, v in ipairs(MarkersPizzero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Pizzero" then
							if player:getData("Roleplay:trabajo") == "Pizzero" then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajo", "")
								player:setData("PizzeroPedidos", false)
								player:triggerEvent("failedMission", player)
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
--
addEvent("giveMoneyPizzero", true)
function giveMoneyPizzero()
	local propinarandom = math.random(1,8)
	local exp = source:getData("Roleplay:ExpJobPizzero") or 1
	local totalMoney = math.ceil(math.random(5,10)*exp/0.7)
	local propina = math.random(6)
	--
	local malasuerte = math.random(1,6)
	if propinarandom == 4 then
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffff + #004500$"..convertNumber(propina).." #FFFFFF de propina por la entrega."
		source:giveMoney(tonumber(totalMoney + propina))
	elseif propinarandom == 5 then
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #963232 - #004500$"..convertNumber(propina).." #FFFFFF llegaste un poco tarde."
		source:giveMoney(tonumber(totalMoney - propina))
	else
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffffpor la entrega."
		source:giveMoney(tonumber(totalMoney))
	end
	source:outputChat(text, 255, 255, 255, true)
end
addEventHandler("giveMoneyPizzero", root, giveMoneyPizzero)

addEvent("givePizzeroExp", true)
function givePizzeroExp()
	source:setData("Roleplay:ExpJobPizzero", source:getData("Roleplay:ExpJobPizzero") + 1)
	source:outputChat("Acabas de obtener + "..source:getData("Roleplay:ExpJobPizzero").." de experiencia en el trabajo de #ffff00pizzero", 255, 255, 255, true)
end
addEventHandler("givePizzeroExp", root, givePizzeroExp)

addEvent("FailedMissionPizzero", true)
function FailedMissionPizzero(placa)
	source:setData("Roleplay:trabajo", "")
	source:setData("PizzeroPedidos", false)
end
addEventHandler("FailedMissionPizzero", root, FailedMissionPizzero)