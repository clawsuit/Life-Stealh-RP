loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

addEventHandler( "onResourceStart", resourceRoot, 
	function()
		for i,v in ipairs(getElementsByType('player', root)) do
			bindKey(v,"i","down", function(player)
				triggerClientEvent(player, 'Open:Inventory', player, getPlayerItems(player)) 
			end)
		end
		query('CREATE TABLE IF NOT EXISTS Inventario (Jugador TEXT, Item TEXT, Value INTEGER)')
	end
)

addEventHandler("onPlayerLogin", getRootElement(), function()
	bindKey(source,"i","down", function(player)
		triggerClientEvent(player, 'Open:Inventory', player, getPlayerItems(player)) 
	end)
end)


function setPlayerItem(player, name, valor)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh <= 0 then
		insert("INSERT INTO Inventario VALUES (?,?,?)", AccountName( player ), name, valor)
	else
		if tonumber(valor) == 0 then
			delete("DELETE FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
		else
			update("UPDATE Inventario SET Value='"..valor.."' WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
		end
	end
end
		
function getPlayerItem(player, name)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh ~= 0 then
		return tonumber(qh[1]["Value"])
	end
	return 0
end

function getReNameItem(player, name, newname)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh ~= 0 then
		databaseUpdate("UPDATE Inventario SET Item=? WHERE Jugador='"..AccountName( player ).."'", newname)
	end
end

function getPlayerItems(player)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."'")
	if #qh ~= 0 then
		return qh
	end
	return {}
end

addEvent( 'Refresh:Inventory', true)
addEventHandler( 'Refresh:Inventory', root,
	function(name, valor)
		if tonumber(valor) <= getPlayerItem(source, name) then

			local tipo,valor = table.find(Objetos, name)
			if tipo == "bebida" then
				local old_value = math.ceil(source:getData('Roleplay:stamina')) or 0
				if (old_value == 100 ) then
					return
				end
				if old_value+valor > 100 then
					valor = 100
				else
					valor = old_value + valor
				end
				source:setData('Roleplay:stamina', valor)
				source:setAnimation("VENDING", "VEND_Drink2_P", -1, true, false, false)
				setTimer(function(p)
					setPedAnimation(p)
				end, 2000, 1, source)

				setPlayerItem(source, name, getPlayerItem(source, name)-1)
			elseif tipo == "hambre" then
				local old_value = math.ceil(source:getHealth()) or 0
				if (old_value == 100 ) then
					return
				end
				if old_value+valor > 100 then
					valor = 100
				else
					valor = old_value + valor
				end
				source:setHealth(valor)
				source:setAnimation("FOOD", "EAT_Chicken", -1, true, false, false)
				setTimer(function(p)
					setPedAnimation(p)
				end, 2000, 1, source)

				setPlayerItem(source, name, getPlayerItem(source, name)-1)
			end
			if name == "Caja de Cigarros" then
				if getPlayerItem(source, "Encendedor") >= 1 then
					source:setData("TextInfo", {"> Saca un cigarro y lo enciende", 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 3000, 1, source)
					source:setAnimation("GANGS", "drnkbr_prtl", 1, false,false)
					setPlayerItem(source, name, getPlayerItem(source, name)-1)
					setPlayerItem(source, "Encendedor", getPlayerItem(source, "Encendedor")-1)
				else
					exports['[LS]Notificaciones']:setTextNoti(source,"Para fumar 1 cigarro debes tener un encendedor en tu inventario", 150, 50, 50, true)
				end
			end
			if name == "Bidon de Gasolina" then
				local veh = getPlayerNearbyVehicle(source)
				if veh then
					local gas = getElementData(veh, "Fuel")
					if gas <= 90 then
						source:setData("TextInfo", {"> Usa su bidon de gasolina y abre el tanque del vehículo para llenarlo", 255, 0, 216})
						setTimer(function(p)
							p:setData("TextInfo", {"", 255, 0, 216})
						end, 2000, 1, source)
						source:setAnimation("COP_AMBIENT", "Copbrowse_loop", -1,true, false, false)
						setElementData(veh, "Fuel", 100)
						setTimer(function(p, veh)
							setPedAnimation(p)
						end, 2000, 1, source, veh)
						setPlayerItem(source, name, getPlayerItem(source, name)-1)
					else
						exports['[LS]Notificaciones']:setTextNoti(source,"Este vehículo tiene la gasolina llena.", 150, 50, 50, true)
					end
				end
			end
			--setPlayerItem(source, name, getPlayerItem(source, name)-1)
			triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source),'refresh')
		end
	end
)

addEvent( 'TiraItem:Inventory', true)
addEventHandler( 'TiraItem:Inventory', root,
	function(name, valor)
		if tonumber(valor) <= getPlayerItem(source, name) then
			setPlayerItem(source, name, getPlayerItem(source, name)-1)
			triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source),'refresh')
		end
	end
)

function getPlayerNearbyVehicle(player)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.5 then
				return veh
			end
		end
	end
	return false
end

Objetos = { 
	['hambre'] = {
		["Pizzeta"] = 5,
		["Pizza Chica"] = 6,
		["Pizza Grande"] = 4,
		["Hamburguesa"] = 4,
		["Hamburguesa Chica"] = 5,
		["Hamburguesa Grande"] = 6,
		["Pata de Pollo"] = 7,
		["Hamb. de Pollo"] = 8,
		["Pollo Asado"] = 10,
		["Galleta"] = 5,
	},
--
	['bebida'] = {
		["Cerveza"] = 5,
		["Agua"] = 20,
		["Lata de Spray"] = 10,
	}
}
--{"Caja de Cigarros", 50},
--{"Encendedor", 25},
--

function table.find(t, item)
	for tipo,comida in pairs(t) do
		for index,value in pairs(comida) do
			if (index == item) then
				return tipo,value
			end
		end
	end
	return false
end

local items = { 
{"Telefono"},
{"Agenda"},
{"Camara"},
{"Cuchillo de Caza (Arma)"},
{"Bidon Vacio"},
{'Bidon de Gasolina'},
{"Lata de Spray"},
{"Pizzeta"},
{"Pizza Chica"},
{"Pizza Grande"},
--
{"Pata de Pollo"},
{"Hamb. de Pollo"},
{"Pollo Asado"},
--
{"Cerveza"},
{"Agua"},
{"Caja de Cigarros"},
{"Encendedor"},
--
{"Hamburguesa"},
{"Hamburguesa Chica"},
{"Hamburguesa Grande"}
}

function isItemExist(itemName)
	for _,v in pairs(items) do
		if (v[1]:lower()) == (itemName:lower()) then
			return v[1]
		end
	end
	return false
end
