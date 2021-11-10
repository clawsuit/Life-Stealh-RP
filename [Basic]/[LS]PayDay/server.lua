loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')



--- setTimers

local globalMoney = 38

local enTrabajoMoney = 70

local faccionMoney = 2350



local rangosMoney = {

["Policia"]={

["Comandante"]=70000,

["Teniente"]=20000,

["General"]=19500,

["Sargento II"]=18000,

["Sargento I"]=15000,

["Oficial III"]=3000,

["Oficial II"]=2500,

["Oficial I"]=1200,

["Cadete"]=700,

},

--

["Medico"]={

["Director"]=40000,

["Sub Director"]=15000,

["Sargento"]=10000,

["Medico"]=3000,

["Paramedico"]=2000,

["Aspirante"]=600,

},

--

["Mecanico"]={

["Dueño"]=18000,

["Junior"]=200,

["Mecanico"]=50,

["Aprendiz"]=10,

},

["Gobierno"]={

["Juez Supremo"]=60000,

["Fiscal"]=45000,

["Maestro de Derecho"]=15000,

["Abogado Estatal"]=10000,

["Abogado Privado"]=150,

["Asistente"]=3000,

["Encargado de Seguridad"]=5000,

["Guardia"]=1000,

["Guarura"]=7500,

}

--

}

Levels = {

{500, 1},

{1000, 2},

{1500, 3},

{2000, 4},

{2500, 5},

{3000, 6},

{3500, 7},

{4000, 8},

{4500, 9},

{5000, 10},

{5500, 11},

{6000, 12},

{6500, 13},

{7000, 14},

{7500, 15},

}


setTimer(function()

	for index, player in ipairs(Element.getAllByType("player")) do

		if not notIsGuest( player ) then

			--

			if player:getData("AFK") == false then

				local vehs = exports["[LS]SistemaVehiculos"]:getLastID(player) or 0

				local vehs = vehs - 1

				local faccion = player:getData("Roleplay:faccion") or ""

				local rango = player:getData("Roleplay:faccion_rango") or ""

				player:outputChat("#1D3F00------------------", 255, 255, 255, true)

				player:outputChat("#1D3F3BDía de Paga", 255, 255, 255, true)

				player:outputChat("#8F6B3BGGobierno: #577B43+ $28", 255, 255, 255, true)

				playSoundFrontEnd (player, 7)

				if player:getData("Roleplay:faccion") ~="" then

					player:outputChat("#8F6B3BFacción: #577B43+ $"..rangosMoney[tostring(faccion)][tostring(rango)], 255, 255, 255, true)

				end

				player:outputChat("#8F6B3BTrabajo: #577B43+$0", 255, 255, 255, true)

				player:outputChat("#8F6B3BImpuestos: #577B43- $"..(vehs * 30).." Vehículos | Casas: -0", 255, 255, 255, true)

				if player:getData("Roleplay:faccion") ~="" then

					player:outputChat("#9C9243Total: #577B43$"..convertNumber(28 + rangosMoney[tostring(faccion)][tostring(rango)] - (vehs * 30) ), 255, 255, 255, true)

					if player:getData("Roleplay:tarjeta_credito") == 1 then

						player:setData("Roleplay:bank_balance", player:getData("Roleplay:bank_balance") + tonumber(math.ceil( 28 + rangosMoney[tostring(faccion)][tostring(rango)] - (vehs * 30) )))

					else

						player:giveMoney(tonumber(math.ceil(28 + rangosMoney[tostring(faccion)][tostring(rango)] - (vehs * 30) )))

					end

				else

					player:outputChat("#9C9243Total: #577B43$"..convertNumber(28 - (vehs * 30)), 255, 255, 255, true)

					if player:getData("Roleplay:tarjeta_credito") == 1 then

						player:setData("Roleplay:bank_balance", player:getData("Roleplay:bank_balance") + tonumber(math.ceil(28 + (vehs * 30))))

					else

						player:giveMoney(tonumber(math.ceil(28 + (vehs * 30))))

					end

				end

				setNivel(player)

			end

		end

	end --

end, 1000*60*60*1 , 0)
 
function setNivel( player )

	if isElement(player) then
		local nivel = tonumber(player:getData("Nivel")) or 1
		local actualExp = player:getData("PlayerExp") or 0

		if nivel == #Levels then

			exports['[LS]Notificaciones']:setTextNoti(player, '¡Estas en tu nivel maximo #ff0000visio#ffffff!', 0,255,0, true)

		elseif nivel < #Levels then

			local nuevaExp = math.random(100,100)
			if actualExp+nuevaExp >= Levels[nivel][1] then

				player:setData("Nivel",nivel+1)
				player:setData('PlayerExp',Levels[nivel][1]-(actualExp+nuevaExp))
				player:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFy subiste al #00FF00nivel "..(nivel+1).." #FFFFFFpor jugar en nuestro servidor!", 255, 255, 255, true)

			elseif actualExp+nuevaExp < Levels[nivel][1] then

				player:setData('PlayerExp', actualExp+nuevaExp)
				player:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFpor jugar en nuestro servidor!", 255, 255, 255, true)
			end
		end

	end
end

--[[function setNivel( player )

	if isElement( player ) and player:getType() == "player" then

		local nivel = player:getData("PlayerNivel") or 1

		local exp = player:getData("PlayerExp") or 0

		for i, v in ipairs(nivels) do

			if exp >= v[1] and nivel == v[2] then

				player:setData("PlayerNivel", nivel + 1)

				player:setData("PlayerExp", 0)

				player:outputChat("* Acabas de subir al nivel: #FFFFFF"..getNivel(player).."", 255, 255, 255, true)

				local total = math.ceil(nivel*5)

				player:outputChat("* Ganas: #0A5E04$ "..(math.ceil(total)).."", 255, 255, 255, true)

				player:giveMoney(math.ceil(total))

			else

				if exp >= 40000 then

					player:setData("PlayerNivel", nivel + 1)

					player:setData("PlayerExp", 0)

					player:outputChat("* Acabas de subir al nivel: #FFFFFF"..getNivel(player).."", 255, 255, 255, true)

					local total = math.ceil(nivel*7)

					player:outputChat("* Ganas: #0A5E04$ "..(math.ceil(total)).."", 255, 255, 255, true)

					player:giveMoney(math.ceil(total))

				end

			end

		end

	end

end







function update_all( )

	for i, v in ipairs(Element.getAllByType("player")) do

		v:setData("Nivel", getNivel( v ) or 0)

	end;

end;

setTimer(update_all, 200000, 0)



function setExp( player )

	if isElement( player ) and player:getType() == "player" then

		local exp = player:getData("PlayerExp") or 0

		player:setData("PlayerExp", exp+tonumber(math.random(5, 10)))

	end

end



function getExp( player )

	if isElement( player ) and player:getType() == "player" then

		return tonumber(player:getData("PlayerExp") or 0)

	else

		return false

	end

	return false

end



function getNivel( player )

	if isElement( player ) and player:getType() == "player" then

		return tonumber(player:getData("PlayerNivel") or 1)

	else

		return false

	end

	return false

end]]