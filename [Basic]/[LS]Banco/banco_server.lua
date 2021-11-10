loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local colsShapes = {}
local antiSpamComando = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getTableATM()) do
		if v[4] == true then
			Blip( v[1], v[2], v[3], 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		end
		colsShapes[i] = ColShape.Sphere(v[1], v[2], v[3], 2)
	end
end)

addCommandHandler("fondo", function(p, cmd, who)
	if not notIsGuest(p) then
		if permisos[getACLFromPlayer(p)] == true then
			if tonumber(who) then
				local player = getPlayerFromPartialNameID(who)
				if (player) then
					local money = p:getData("Roleplay:bank_balance")
					if money then
						p:outputChat("#FF0033"..player:getName().." tiene en el banco $ #004500"..convertNumber(money).." dólares.", 255, 255, 255, true)
					end
				end
			else
				local player = getPlayerFromPartialName(who)
				if (player) then
					local money = p:getData("Roleplay:bank_balance")
					if money then
						p:outputChat("#FF0033"..player:getName().." tiene en el banco $ #004500"..convertNumber(money).." dólares.", 255, 255, 255, true)
					end
				end
			end
		end
		--
		if not p:isInVehicle() then
			local tick = getTickCount()
			if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 1000) then
				p:outputChat("Debes esperar 1 segundo después de ser utilizado.", 150, 0, 0)
				return
			end
			for i, v in ipairs(colsShapes) do
				if p:isWithinColShape(v) then
					local s = p:getData("Roleplay:tarjeta_credito")
					if s == 1 then
						local money = p:getData("Roleplay:bank_balance")
						if money then
							p:outputChat("Tu fondo en total es de: #00FF00$"..convertNumber(money), 255, 255, 255, true)
						end
					else
						p:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
					end
				end
			end
			if (not antiSpamComando[p]) then
				antiSpamComando[p] = {}
			end
			antiSpamComando[p][1] = getTickCount()
		end
	end
end)

addCommandHandler("depositar", function(p, cmd, monto)
	if not notIsGuest(p) then
		if tonumber(monto) then
			monto = math.round(math.abs(monto))
			if not p:isInVehicle() then
				local tick = getTickCount()
				if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 1000) then
					p:outputChat("Debes esperar 1 segundo después de ser utilizado.", 150, 0, 0)
					return
				end
				for i, v in ipairs(colsShapes) do
					if p:isWithinColShape(v) then
						local s = p:getData("Roleplay:tarjeta_credito")
						if s == 1 then
							if monto and tonumber(monto) ~= nil then
								if p:getMoney() >= tonumber(monto) then
									if p:getMoney() >= 1 then
										local account = p:getAccount()
										local money = p:getData("Roleplay:bank_balance")
										local total = tonumber(money)+monto
										p:setData ( "Roleplay:bank_balance", tonumber(total) )
										account:setData( "Roleplay:bank_balance", tonumber(total) )
										--
										p:takeMoney(tonumber(monto))
										outputDebugString("* "..p:getName().." ha depositado: $"..convertNumber(monto).." ", 0, 0, 150, 0)
										p:outputChat("* Has depositado la cantidad: #004500$"..convertNumber(monto).." dólares.", 0, 150, 0, true)
										--
										local f = getRealTime()
										insert("insert into `BancoLog` VALUES (?,?,?,?)", convertNumber(monto), "Deposito", f.monthday.."/"..f.month+1 .."/"..f.year-100, AccountName(p))
									else
										p:outputChat("* No tienes dinero para depositar", 150, 0, 0)
									end
								else
									p:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para depositar", 150, 0, 0)
								end
							end
						else
							p:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
						end
					end
				end
				if (not antiSpamComando[p]) then
					antiSpamComando[p] = {}
				end
				antiSpamComando[p][1] = getTickCount()
			end
		end
	end
end)

addCommandHandler("retirar", function(p, cmd, monto)
	if not notIsGuest(p) then
		if tonumber(monto) then
			monto = math.round(math.abs(monto))
			if not p:isInVehicle() then
				local tick = getTickCount()
				if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 1000) then
					p:outputChat("Debes esperar 1 segundo después de ser utilizado.", 150, 0, 0)
					return
				end
				for i, v in ipairs(colsShapes) do
					if p:isWithinColShape(v) then
						local s = p:getData("Roleplay:tarjeta_credito")
						if s == 1 then
							if monto and tonumber(monto) ~= nil then
								local money = p:getData("Roleplay:bank_balance")
								if tonumber(money) >= tonumber(monto) then
									local account = p:getAccount()
									local total = tonumber(money)-monto
									p:setData ( "Roleplay:bank_balance", tonumber(total) )
									account:setData( "Roleplay:bank_balance", tonumber(total) )
									p:giveMoney (monto)
									outputDebugString("* "..p:getName().." ha retirado: $"..convertNumber(monto).." ", 0, 150, 0, 0)
									p:outputChat("* Has retirado la cantidad: #004500$"..convertNumber(monto).." dólares.", 150, 0, 0, true)
									--
										local f = getRealTime()
									insert("insert into `BancoLog` VALUES (?,?,?,?)", convertNumber(monto), "Retiro", f.monthday.."/"..f.month+1 .."/"..f.year-100, AccountName(p))
								else
									p:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para retirar", 150, 0, 0)
								end
							end
						else
							p:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
						end
					end
				end
				if (not antiSpamComando[p]) then
					antiSpamComando[p] = {}
				end
				antiSpamComando[p][1] = getTickCount()
			end
		end
	end
end)

permisos = {
["Administrador"]=true,
}

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end