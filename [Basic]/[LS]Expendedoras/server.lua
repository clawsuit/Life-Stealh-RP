loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

local Nop = {}
local Expendedoras = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for ExpendedoraName, info in pairs(getExpendedoras()) do
		for i, v in ipairs(info) do
			Expendedoras[ExpendedoraName] = Expendedoras[ExpendedoraName] or {}
			Expendedoras[ExpendedoraName][i] = Marker(v.pos[1], v.pos[2], v.pos[3]-1, "cylinder", 1.1, 200, 0, 101, 0)
			Expendedoras[ExpendedoraName][i]:setInterior(v.int)
			Expendedoras[ExpendedoraName][i]:setDimension(v.dim)
			setDato(Expendedoras[ExpendedoraName][i], "AnimMarker", {v.anim[1], v.anim[2], v.gasto}, true)
		end
	end
end)

_addCommandHandler = addCommandHandler
function addCommandHandler(comando, func)
    if type(comando) == 'table' then
        for i,v in ipairs(comando) do
            _addCommandHandler(v, func)
        end
    else
        return _addCommandHandler(comando, func)
    end
end

addCommandHandler({"expendedora", "agua"}, function(p)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			if not Nop[p] == true then
				for i, v in pairs(Expendedoras) do
					for _, marker in ipairs(v) do
						if p:isWithinMarker(marker) then
							local s = getDato(marker, "AnimMarker")
							local money = p:getMoney()
							if money >= s[3] then
								--
								Nop[p] = true
								if i == "Sprunk" then
									p:outputChat("Acabas de comprar una lata de spray: #009B0075 Dolares.", 255, 255, 255, true)
									exports["[LS]Tiendas"]:setPlayerItem(p, "Lata de Spray", exports["[LS]Tiendas"]:getPlayerItem(p, "Lata de Spray")+1)
									p:takeMoney(75)
								elseif i == "Golosinas" then
									p:outputChat("Acabas de comprar una golosina: #009B0030 Dolares.", 255, 255, 255, true)
									exports["[LS]Tiendas"]:setPlayerItem(p, "Galleta", exports["[LS]Tiendas"]:getPlayerItem(p, "Galleta")+1)
									p:takeMoney(30)
								elseif i == "Agua" then
									p:outputChat("Acabas de tomar un vaso de agua.", 255, 255, 255, true)
								end
								p:setAnimation(s[1], s[2], -1, true, false, false)
								setTimer(function(p)
								setPedAnimation(p)
								Nop[p] = nil
								end, 3000, 1, p)
							else
								p:outputChat("* No tienes suficiente dinero para comprar.", 150, 50, 50, true)
							end
						end
					end
				end
			end
		end
	end
end)