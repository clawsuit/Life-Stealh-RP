function verOrganos(source)
	local pAccount = source:getAccount()
	local ojos = pAccount:getData("Ojos") or "Si"
	local estomago = pAccount:getData("Estomago") or "Si"
	local corazon = pAccount:getData("Corazon") or "Si"
	source:outputChat("* Tus Organos *", 255, 255, 255)
	source:outputChat("* Ojos: #FFFFFF"..ojos.."", 255, 200, 0, true)
	source:outputChat("* Estomago: #FFFFFF"..estomago.."", 255, 200, 0, true)
	source:outputChat("* Corazon: #FFFFFF"..corazon.."", 255, 200, 0, true)
end
addCommandHandler("verorganos", verOrganos)

--[[function quitarOrganos(source)
	local pAccount = source:getAccount()
	pAccount:setData("Ojos", "No")
	pAccount:setData("Estomago", "No")
	pAccount:setData("Corazon", "No")
end
addCommandHandler("qorganos", quitarOrganos)

function darOrganos(source)
	local pAccount = source:getAccount()
	pAccount:setData("Ojos", "Si")
	pAccount:setData("Estomago", "Si")
	pAccount:setData("Corazon", "Si")
end
addCommandHandler("sorganos", darOrganos)]]

function efectoOrganos()
	for k, v in ipairs(getElementsByType("player")) do
		efectoCorazon(v)
		efectoOjos(v)
	end
end
local refreshTimer = setTimer(efectoOrganos, 30000, 0)

function efectoCorazon(player)
	local pAccount = player:getAccount()
	if pAccount:getData("Corazon") == "No" then
		player:setHealth(player:getHealth() - 3)
		player:outputChat("* Estas muriendo lentamente, por una extraña razon", 255, 200, 0)
	end
end

function efectoOjos(player)
	local pAccount = player:getAccount()
	if pAccount:getData("Ojos") == "No" then
		fadeCamera(player, false, 1.0, 0, 0, 0)
		setTimer(fadeCamera, 1000, 1, player, true, 0.5) 
		player:outputChat("* Estas comenzando a tener una leve ceguera", 255, 200, 0)
	end
end

function animAcostarse(source)
	local pAccount = source:getAccount()
	local acostado = pAccount:getData("EstaAcostado") or "No"
	if acostado == "No" then
		pAccount:setData("EstaAcostado", "Si")
		source:setAnimation("crack", "crckidle2", -1, true, false, false)
		source:outputChat("* Te acabas de acostar (para quitar la anim /acostarse nuevamente)", 255, 200, 0)
	else
		pAccount:setData("EstaAcostado", "No")
		source:setAnimation(false)
		source:outputChat("* Te acabas de levantar", 255, 200, 0)
	end
end
addCommandHandler("acostarse", animAcostarse)

local tablaOrganos = {
	["Ojos"] = true,
	["Estomago"] = true,
	["Corazon"] = true,
}

local mesaOperaciones = createColCuboid(-239.69327, 1399.30554, 68.93652, 10.250946044922, 9.2738037109375, 4.3018249511719)

function operarJugador(source, cmd, player, organo)
	local jugador = getPlayerFromPartialName(player)
	if player == "" or player == nil or player == false then
		source:outputChat("* Introduce al jugador que deseas operar", 255, 200, 0)
		return
	end
	if not isElementWithinColShape(jugador, mesaOperaciones) then
		source:outputChat("* El jugador o tu tienen que estar mas cerca de la mesa de operaciones", 255, 200, 0)
		return
	end
	if exports["[LS]Tiendas"]:getPlayerItem(source, "Bisturi") < 1 then
		source:outputChat("* No puedes operar si no tienes un Bisturi", 255, 200, 0)
		return
	end
	if source == jugador then
		source:outputChat("* No te puedes quitar los organos a ti mismo", 255, 200, 0)
		return
	end
	if tablaOrganos[organo] == true then
		local pAccount = jugador:getAccount()
		if pAccount:getData(organo) == "No" then
			source:outputChat("* Este jugador ya no tiene ese organo", 255, 200, 0)
			return
		end
		local itemActual = exports["[LS]Tiendas"]:getPlayerItem(source, organo) or 0
		exports["[LS]Tiendas"]:setPlayerItem(source, organo, itemActual + 1)
		pAccount:setData(organo, "No")
		source:outputChat("* Operaste el: "..organo.." a "..jugador:getName().."", 255, 200, 0)
		outputDebugString(source:getName()..", ("..source:getData("Roleplay:faccion")..") - Opero a "..jugador:getName().." ("..jugador:getData("Roleplay:faccion")..")", 0, 110, 210, 150)
	else
		source:outputChat("* Introduce un organo valido (Ojos, Estomago, Corazon)", 255, 200, 0)
	end
end
addCommandHandler("operar", operarJugador)

local zonaCirujia = createColCuboid(1571.71667, 1809.43140, 2078.38770, 21.501098632813, 16.594848632813, 9.725927734375)
zonaCirujia:setDimension(9)
zonaCirujia:setInterior(3)

function cirujiaJugador(source, cmd, player, organo)
	local jugador = getPlayerFromPartialName(player)
	if player == "" or player == nil or player == false then
		source:outputChat("* Introduce al jugador que deseas operar", 255, 200, 0)
		return
	end
	if source:getData("Roleplay:faccion") ~= "Medico" then
		source:outputChat("* Solo los medicos pueden usar esto", 255, 200, 0)
		return
	end
	if not isElementWithinColShape(jugador, zonaCirujia) then
		source:outputChat("* El jugador o tu tienen que estar mas cerca de la mesa de operaciones", 255, 200, 0)
		return
	end
	if tablaOrganos[organo] == true then
		local pAccount = jugador:getAccount()
		if pAccount:getData(organo) == "Si" then
			source:outputChat("* Este jugador ya tiene ese organo", 255, 200, 0)
			return
		end
		local acostado = pAccount:getData("EstaAcostado") or "No"
		if acostado == "No" then
			source:outputChat("* El jugador tiene que estar acostado para poder ser operado", 255, 200, 0)
			return
		end
		pAccount:setData(organo, "Si")
		source:outputChat("* Realizaste una operacion de "..organo.." a "..jugador:getName(), 255, 200, 0)
		jugador:outputChat("* Te acaban de realizar una operacion de: "..organo, 255, 200, 0)
	else
		source:outputChat("* Introduce un organo valido (Ojos, Estomago, Corazon)", 255, 200, 0)
	end
end
addCommandHandler("cirugia", cirujiaJugador)

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end 