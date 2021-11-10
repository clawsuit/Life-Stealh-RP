_AutosCreados = {}
local Concesionario = {}
Concesionario.__index = Concesionario
Concesionario['vDatos'] = {}

local bikes = {
[581]=true,
[462]=true,
[521]=true,
[463]=true,
[522]=true,
[461]=true,
[448]=true,
[468]=true,
[586]=true,
[523]=true,
[471]=true,
}

bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}


local clasics_col = createColCuboid( 1213.7644042969, -1677.3040771484, 10.776894569397, 32.6, 40.2, 10) 

local clasics_col2 = createColCuboid(519.07794189453, -1298.6530761719, 15.122941970825, 47.8, 17, 10)

local clasics_col3 = createColCuboid(978.00091552734, -1310.2713623047, 12.366237640381, 37.4, 15.1, 10)

function Concesionario:constructor(array)
	local _i = #self.vDatos + 1
	self.vDatos[_i] = {}
	self.vDatos[_i].Veh = createVehicle(array.ID, array.Pos[1],array.Pos[2],array.Pos[3]-0.3, array.Rot[1],array.Rot[2],array.Rot[3])
	self.vDatos[_i].Veh:setDamageProof( true )
	self.vDatos[_i].Veh:setLocked(true)
	self.vDatos[_i].Veh:setData('Motor','apagado')
	self.vDatos[_i].Veh:setEngineState(false)
	self.vDatos[_i].Veh:setFrozen(true)
	if bikes[array.ID] then
		self.vDatos[_i].Veh:setData("LockedVeh", true)
	end
	if bicicletas[array.ID] then
		self.vDatos[_i].Veh:setData("LockedVeh", true)
	end
	setElementInterior( self.vDatos[_i].Veh, array.Int )
	setElementDimension( self.vDatos[_i].Veh, array.Int )

	--[[self.vDatos[_i].Col = createColCuboid(array.Pos[1],array.Pos[2],array.Pos[3], 5,5,2.5)
			setElementInterior( self.vDatos[_i].Col, array.Int )
			setElementDimension( self.vDatos[_i].Col, array.Int )
			self.vDatos[_i].Col:attach(self.vDatos[_i].Veh)]]
	self.vDatos[_i].Name = getVehicleNameFromModel( array.ID )
	self.vDatos[_i].Costo = array.Costo
	self.vDatos[_i].Fuel = array.Fuel
	self.vDatos[_i].Slots = array.Slots

	setmetatable(self.vDatos[_i], self):intCommands()
end

function Concesionario:intCommands()
	self.F_infoCar = bind(Concesionario.infoCar, self)
	addCommandHandler('infoveh',self.F_infoCar)

	self.F_Comprar = bind(Concesionario.Comprar, self)
	addCommandHandler('comprarvehiculo',self.F_Comprar)
end

function Concesionario:infoCar(jugador)
	local pos = self.Veh.position
	if isPedWithinRange(pos.x,pos.y,pos.z,1.8,jugador) then
		jugador:outputChat('Vehiculo: #001F4C'..self.Name..'#FFFFFF Costo de:#004500 $'..convertNumber(self.Costo)..' dolares #FFFFFF Espacio de Maletero: #001F4C'..self.Slots, 255, 255, 255, true)
	end
end

function Concesionario:Comprar(player)
	local pos = self.Veh.position
	if isPedWithinRange(pos.x,pos.y,pos.z,2,player) then
		if player:getMoney() >= tonumber(self.Costo) then
			if player:isWithinColShape(clasics_col) then
				local id = tonumber(getLastID(player))
				if (not getPlayerVIP(player) and id-1 < 2) or (getPlayerVIP(player) == "VIPNormal" and id-1 < 3) or (getPlayerVIP(player) == "VIPPro" and id-1 < 4 )then
					local X,Y,Z,rX,rY,rZ = getFreePosition('clasics_col')
					local r, g, b, r2, g2, b2 = self.Veh:getColor(true)
					local maletero = {Slots=self.Slots,Items={}}
					local placa = player.name:sub(1, player.name:find('_')-1)..' '..id
					local gasolina = math.random(50, self.Fuel)
					local account = AccountName(player)

					for pi = 1,self.Slots do
						maletero.Items[tostring(pi)] = {'Vacio'}
					end

					_AutosCreados[account] = _AutosCreados[account] or {}
					_AutosCreados[account][id] = createVehicle(getVehicleModelFromName(self.Name), X,Y,Z,rX,rY,rZ)
					_AutosCreados[account][id]:setColor(r, g, b, r2, g2, b2)
					_AutosCreados[account][id]:setLocked(true)
					_AutosCreados[account][id]:setEngineState(false)
					_AutosCreados[account][id]:setPlateText(placa)

					_AutosCreados[account][id]:setData('Owner', account)
					_AutosCreados[account][id]:setData('Maletero', maletero)
					_AutosCreados[account][id]:setData('ID', id) -- opcional
					_AutosCreados[account][id]:setData('Locked', 'Cerrado')
					_AutosCreados[account][id]:setData("Fuel", 100)
					_AutosCreados[account][id]:setData('Kilometraje', 0)

	
					player:takeMoney(tonumber(self.Costo))
					-- aqui pondremos para que se cree el auto y algunos datos para el auto que se le dará
					exports["[LS]Notificaciones"]:setTextNoti(player, "Tu vehículo se encuentra afuera estacionado", 50, 150, 50, true)
					exports['[LS]Notificaciones']:setTextNoti(player, "Compraste el vehiculo "..(self.Name)..' por un costo de '..(self.Costo)..'$', 255, 0, 210)
					insertDat(player, id, getVehicleModelFromName(self.Name), self.Costo, X,Y,Z, rZ, r, g, b, r2, g2, b2, placa, toJSON(maletero), 100)
				end
			elseif player:isWithinColShape(clasics_col2) then
				local id = tonumber(getLastID(player))
				if (not getPlayerVIP(player) and id-1 < 2) or (getPlayerVIP(player) == "VIPNormal" and id-1 < 3) or (getPlayerVIP(player) == "VIPPro" and id-1 < 4 )then
					local X,Y,Z,rX,rY,rZ = getFreePosition('clasics_col2')
					local r, g, b, r2, g2, b2 = self.Veh:getColor(true)
					local maletero = {Slots=self.Slots,Items={}}
					local placa = player.name:sub(1, player.name:find('_')-1)..' '..id
					local gasolina = math.random(50, self.Fuel)
					local account = AccountName(player)

					_AutosCreados[account] = _AutosCreados[account] or {}
					_AutosCreados[account][id] = createVehicle(getVehicleModelFromName(self.Name), X,Y,Z,rX,rY,rZ)
					_AutosCreados[account][id]:setColor(r, g, b, r2, g2, b2)
					_AutosCreados[account][id]:setLocked(true)
					_AutosCreados[account][id]:setEngineState(false)
					_AutosCreados[account][id]:setPlateText(placa)

					_AutosCreados[account][id]:setData('Owner', account)
					_AutosCreados[account][id]:setData('Maletero', maletero)
					_AutosCreados[account][id]:setData('ID', id) -- opcional
					_AutosCreados[account][id]:setData('Locked', 'Cerrado')
					_AutosCreados[account][id]:setData("Fuel", 100)
					_AutosCreados[account][id]:setData('Kilometraje', 0)

	
					player:takeMoney(tonumber(self.Costo))
					-- aqui pondremos para que se cree el auto y algunos datos para el auto que se le dará
					exports['[LS]Notificaciones']:setTextNoti(player, "Compraste el vehiculo "..(self.Name)..' por un costo de '..(self.Costo)..'$', 255, 0, 210)
					insertDat(player, id, getVehicleModelFromName(self.Name), self.Costo, X,Y,Z, rZ, r, g, b, r2, g2, b2, placa, toJSON(maletero), 100)
				end
			elseif player:isWithinColShape(clasics_col3) then
				local id = tonumber(getLastID(player))
				if (not getPlayerVIP(player) and id-1 < 2) or (getPlayerVIP(player) == "VIPNormal" and id-1 < 3) or (getPlayerVIP(player) == "VIPPro" and id-1 < 4 )then
					local X,Y,Z,rX,rY,rZ = getFreePosition('clasics_col3')
					local r, g, b, r2, g2, b2 = self.Veh:getColor(true)
					local maletero = {Slots=self.Slots,Items={}}
					local placa = player.name:sub(1, player.name:find('_')-1)..' '..id
					local gasolina = math.random(50, self.Fuel)
					local account = AccountName(player)

					_AutosCreados[account] = _AutosCreados[account] or {}
					_AutosCreados[account][id] = createVehicle(getVehicleModelFromName(self.Name), X,Y,Z,rX,rY,rZ)
					_AutosCreados[account][id]:setColor(r, g, b, r2, g2, b2)
					_AutosCreados[account][id]:setLocked(true)
					_AutosCreados[account][id]:setEngineState(false)
					_AutosCreados[account][id]:setPlateText(placa)
					--
					if bikes[_AutosCreados[account][id]] then
						_AutosCreados[account][id]:setData("LockedVeh", true)
					end

					if bicicletas[_AutosCreados[account][id]] then
						_AutosCreados[account][id]:setData("CandadoBicicleta", true)
					end
					--

					_AutosCreados[account][id]:setData('Owner', account)
					_AutosCreados[account][id]:setData('Maletero', maletero)
					_AutosCreados[account][id]:setData('ID', id) -- opcional
					_AutosCreados[account][id]:setData('Locked', 'Cerrado')
					_AutosCreados[account][id]:setData("Fuel", 100)
					_AutosCreados[account][id]:setData('Kilometraje', 0)

	
					player:takeMoney(tonumber(self.Costo))
					-- aqui pondremos para que se cree el auto y algunos datos para el auto que se le dará
					exports['[LS]Notificaciones']:setTextNoti(player, "Compraste el vehiculo "..(self.Name)..' por un costo de '..(self.Costo)..'$', 255, 0, 210)
					exports['[LS]Notificaciones']:setTextNoti(player, "Ve afuera tu moto se encuentra estacionado ahí.", 255, 0, 210)
					insertDat(player, id, getVehicleModelFromName(self.Name), self.Costo, X,Y,Z, rZ, r, g, b, r2, g2, b2, placa, toJSON(maletero), 100)
				end
			end
		else
			exports["[LS]Notificaciones"]:setTextNoti(player, "* No tienes suficiente dinero para comprar este vehículo.", 150, 50, 50)
		end
	end
end

local posiciones_c = {
	clasics_col = {
		{1282.5046386719, -1666.21875, 13.546875, -0, 0, 268.8528137207},
		{1282.998046875, -1671.7686767578, 13.546875, -0, 0, 268.8528137207},
		{1283.0360107422, -1683.1031494141, 13.546875, -0, 0, 268.8528137207},
	},
	--
	clasics_col2 ={
		{550.90734863281, -1264.0139160156, 17.2421875, -0, 0, 223.06651306152},
		{550.90734863281-4, -1264.0139160156, 17.2421875, -0, 0, 223.06651306152},
		{550.90734863281-8, -1264.0139160156, 17.2421875, -0, 0, 223.06651306152},
	},
	clasics_col3 ={
		{1004.1114501953, -1312.4281005859, 13.546875, -0, 0, 178.50473022461},
		{1000.3649291992, -1312.603515625, 13.546875, -0, 0, 178.50473022461},
		{991.92132568359, -1312.7032470703, 13.546875, -0, 0, 178.50473022461}
	}
}

function getFreePosition(key)
	local x,y,z,rx,ry,rz = 0,0,0,0,0,0
	for i,v in ipairs(posiciones_c[key]) do
		local col = createColSphere( v[1],v[2],v[3], 2 )
		local _counts = col:getElementsWithin('vehicle')
		if #_counts == 0 then
			x,y,z,rx,ry,rz = v[1],v[2],v[3],v[4],v[5],v[6]
			if isElement(col) then
				col:destroy()
			end
			return x,y,z,rx,ry,rz
		else
			if isElement(col) then
				col:destroy()
			end
		end
	end
	x,y,z,rx,ry,rz = unpack(posiciones_c[key][math.random(1,#posiciones_c[key])])
	return x,y,z,rx,ry,rz
end


addEventHandler( "onResourceStart", getResourceRootElement(  ), 
	function()
		for i,v in ipairs(Vehicle_Datos) do
			Concesionario:constructor(v)
		end
		for i,player in ipairs(Element.getAllByType('player')) do
			bindKey(player,"l","down",abrirMyVehicle)
			crearVehiculosJugador(player)
		end

	end
)

addEventHandler( "onResourceStop", getResourceRootElement(  ), 
	function()
		for i,player in ipairs(Element.getAllByType('player')) do
			guardarVehiculosJugador(player)
		end
	end
)

addEventHandler( "onPlayerLogin", getRootElement(),
	function()
		crearVehiculosJugador(source)
		bindKey(source,"l","down",abrirMyVehicle)
	end
)

addEventHandler( "onPlayerQuit", getRootElement(),
	function()
		guardarVehiculosJugador(source)
	end
)
local antiSpamCommnd = {}

function abrirMyVehicle(p)
	local veh = getPlayerNearbyVehicle(p)
	if veh then
		local ID = getElementData(veh, 'ID') or false
		if ID then
			local tick = getTickCount()
			if (antiSpamCommnd[p] and antiSpamCommnd[p][1] and tick - antiSpamCommnd[p][1] < 500) then
				return
			end
			local owner = getElementData(veh,'Owner')
			if owner and owner == p.account.name then
				local state = getElementData(veh, 'Locked')
				if state == 'Abierto' then

					veh:setLocked(true)
					veh:setData('Locked', 'Cerrado')
					exports['[LS]Notificaciones']:setTextNoti(p, "> cerro su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 210)
					p:setData("TextInfo", {"> cerro su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 2000, 1, p)
					
				else
					
					veh:setLocked(false)
					veh:setData('Locked', 'Abierto')
					exports['[LS]Notificaciones']:setTextNoti(p, "> abrio su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 210)
					p:setData("TextInfo", {"> abrio su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 2000, 1, p)
				
				end
			end
			if (not antiSpamCommnd[p]) then
				antiSpamCommnd[p] = {}
			end
			antiSpamCommnd[p][1] = getTickCount()
		end
	end
end

function crearVehiculosJugador(player)
	local account = AccountName(player)
	local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."'")
	if #datos > 0 then
		for k,v in pairs(datos) do

			local color = split( v.Color, ',' )
			local account = AccountName(player)
			local id = tonumber(v.ID)
			_AutosCreados[account] = _AutosCreados[account] or {}
			_AutosCreados[account][id] = createVehicle(tonumber(v.Modelo), v.X,v.Y,v.Z,0,0,v.rotZ)
			_AutosCreados[account][id]:setColor(color[1],color[2],color[3],color[4],color[5],color[6])
			_AutosCreados[account][id]:setLocked(true)
			_AutosCreados[account][id]:setEngineState(false)
			_AutosCreados[account][id]:setPlateText(tostring(v.Placa))
			_AutosCreados[account][id]:setHealth(tonumber(v.Vida))

			_AutosCreados[account][id]:setData('Owner', v.Cuenta)
			_AutosCreados[account][id]:setData('Maletero', fromJSON(v.Maletero))
			_AutosCreados[account][id]:setData('ID', tonumber(v.ID)) -- opcional
			_AutosCreados[account][id]:setData('Locked', 'Cerrado')
			_AutosCreados[account][id]:setData("Fuel", tonumber(v.Gasolina))
			_AutosCreados[account][id]:setData('Kilometraje', tonumber(v.Kilometraje))

			for i, upgrade in ipairs(split(v.Upgrades, ',')) do
				addVehicleUpgrade(_AutosCreados[account][id], upgrade)
			end
			setVehiclePaintjob(_AutosCreados[account][id], (tonumber(v.Paint) or 3))
		end
	end
end

function guardarVehiculosJugador(player)
	local account = AccountName(player)
	local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."'")
	if #datos > 0 then
		local autos = _AutosCreados[account]
		if autos then
			for i = 1, #autos do
				local id = getElementData(autos[i],'ID')
				local vida = autos[i]:getHealth()
				local fuel = getElementData(autos[i],"Fuel") or 0
				local x,y,z = getElementPosition(autos[i])
				local _,_,rz = getElementRotation( autos[i] )
				local km = getElementData(autos[i],'kilometraje')
				local maletero = toJSON(getElementData(autos[i],'Maletero'))
				local paintjob = autos[i]:getPaintjob()
				local r, g, b, r2, g2, b2 = autos[i]:getColor(true)
				local upgrade = ""
				for _, upgradee in ipairs (autos[i]:getUpgrades()) do
					if upgrade == "" then
						upgrade = upgradee
					else
						upgrade = upgrade..","..upgradee
					end
				end
				local account = AccountName(player)
				local s = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."' AND ID ='"..id.."'")
				if #s > 0 then
					local color = r..","..g..","..b..","..r2..","..g2..","..b2
					databaseUpdate("UPDATE Info_Vehicles SET X=?,Y=?,Z=?,rotZ=?,Vida=?,Color=?,Maletero=?,Gasolina=?,Upgrades=?,Paint=?,Kilometraje=? WHERE Cuenta='"..account.."' AND ID ='"..id.."'", x, y, z, rz,vida,color,maletero,fuel,upgrade,paintjob,km)
				end
			end
			for i = 1, #autos do
				if isElement(autos[i]) then
					autos[i]:destroy()
				end
			end
			_AutosCreados[account] = nil
		end
	end
end
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

function insertDat(player, id, modelo, cost, x, y, z, rz, r, g, b, r2, g2, b2, placa, maletero, gasolina, upgrades, paintjob,vida,km)
	if isElement(player) then
		local account = AccountName(player)
		local s = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."' AND ID ='"..id.."'")
		if #s == 0 or not s then
			local color = r..","..g..","..b..","..r2..","..g2..","..b2
			databaseInsert("INSERT INTO Info_Vehicles VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", id, account, modelo, gasolina, x, y, z, rz, 1000, '', '', color, placa, maletero, cost,0)
		end
	end
end

function getLastID(player)
    if isElement( player ) then
        local result = databaseQuery("SELECT * FROM Info_Vehicles WHERE Cuenta=?", AccountName(player))
        return (#result or 0) + 1
    end
end

function getPlayerVIP(player)
	if isElement(player) then
		local accName = getAccountName ( getPlayerAccount ( player ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIPPro" ) ) then
			return "VIPPro"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIPNormal" ) ) then
			return "VIPNormal"
		else
			return false
		end
	end
	return false
end

function bind(func, ...)
	if not func then
		if DEBUG then
			outputConsole(debug.traceback())
			outputServerLog(debug.traceback())
		end
		error("Bad function pointer @ bind. See console for more details")
	end
	
	local boundParams = {...}
	return 
		function(...) 
			local params = {}
			local boundParamSize = select("#", unpack(boundParams))
			for i = 1, boundParamSize do
				params[i] = boundParams[i]
			end
			
			local funcParams = {...}
			for i = 1, select("#", ...) do
				params[boundParamSize + i] = funcParams[i]
			end
			return func(unpack(params)) 
		end 
end

function isPedWithinRange(x,y,z,range,ped)
	for _, type in ipairs({'player','ped'}) do
		for k,v in pairs(getElementsWithinRange(x,y,z,range, type)) do
			if v == ped then
				return true
			end
		end
	end
	return false;
end






