loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
--

local Vehicles_s = {}
Vehicles_s.__index = Vehicles_s

permisos = {
["Administrador"]=true,
}

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

function Vehicles_s:constructor(array, faction)

	self.vehicles = self.vehicles or {}
	local plate = array.Placa:lower()
	self.vehicles[plate] = self.vehicles[plate] or {}
	local index = #self.vehicles[plate] + 1
	self.vehicles[plate][index] = setmetatable({},self)

	self.vehicles[plate][index].Veh = createVehicle(array.ID, array.Pos[1],array.Pos[2],array.Pos[3], array.Rot[1],array.Rot[2],array.Rot[3])
	self.vehicles[plate][index].Veh:setRespawnPosition(array.Pos[1],array.Pos[2],array.Pos[3], array.Rot[1],array.Rot[2],array.Rot[3])
	self.vehicles[plate][index].Veh:setPlateText( array.Placa..index )
	self.vehicles[plate][index].Veh:setLocked(true)
	self.vehicles[plate][index].Veh:setFrozen(true)
	self.vehicles[plate][index].Veh:setData("VehiculoPublico", faction)
	if bikes[array.ID] then
		self.vehicles[plate][index].Veh:setData("LockedVeh", true)
	end
	setElementData(self.vehicles[plate][index].Veh, 'Fuel', array.Fuel)
	setElementInterior( self.vehicles[plate][index].Veh, array.Int)
	setElementDimension( self.vehicles[plate][index].Veh, array.Dim )
	--removeVehicleSirens(self.vehicles[plate][index].Veh)
	self.vehicles[plate][index].State = true
	self.vehicles[plate][index].Fuel = array.Fuel
	self.vehicles[plate][index].Placa = array.Placa
	self.vehicles[plate][index].Faction = faction
	self.vehicles[plate][index].Rango = array.Rango
	self.vehicles[plate][index].Pos = array.Pos
	self.vehicles[plate][index].Rot = array.Rot
	
	self.vehicles[plate][index].F_openClose = bind(Vehicles_s.openClose, self.vehicles[plate][index])

	for _,player in ipairs(Element.getAllByType('player')) do
		bindKey(player,"l","down", self.vehicles[plate][index].F_openClose )
	end
	addCommandHandler({"bloqueo", "abrir", "cerrar"}, self.vehicles[plate][index].F_openClose )

	self.vehicles[plate][index].F_EnterPlayer = bind(Vehicles_s.EnterPlayer, self.vehicles[plate][index])
	addEventHandler( "onPlayerJoin", getRootElement(), self.vehicles[plate][index].F_EnterPlayer )
end

function Vehicles_s:EnterPlayer()
	bindKey(source,"l","down", self.F_openClose )
end

function Vehicles_s:openClose(p)
	if p:getData('Roleplay:faccion') == self.Faction or p:getData("Roleplay:trabajo") == self.Faction or p:getData("Roleplay:Mision") == self.Faction then
		local pos = self.Veh.position
		if isPedWithinRange(pos.x,pos.y,pos.z,self.Rango,p) then
			if self.Veh:isLocked() then
				self.Veh:setLocked(false)
				self.Veh:setFrozen(false)
				if bikes[self.Veh:getModel()] then
					self.Veh:setData("LockedVeh", false)
				end
				exports['[LS]Notificaciones']:setTextNoti(p, "> abrio su ".. getVehicleNameFromModel(self.Veh:getModel()), 255, 0, 210)
				p:setData("TextInfo", {"> abrió su ".. getVehicleNameFromModel(self.Veh:getModel()), 255, 0, 216})
				setTimer(function(p)
					p:setData("TextInfo", {"", 255, 0, 216})
				end, 2000, 1, p)
			else
				self.Veh:setLocked(true)
				if bikes[self.Veh:getModel()] then
					self.Veh:setData("LockedVeh", true)
				end
				exports['[LS]Notificaciones']:setTextNoti(p, "> cerro su ".. getVehicleNameFromModel(self.Veh:getModel()), 255, 0, 210)
				p:setData("TextInfo", {"> cerro su ".. getVehicleNameFromModel(self.Veh:getModel()), 255, 0, 216})
				setTimer(function(p)
					p:setData("TextInfo", {"", 255, 0, 216})
				end, 2000, 1, p)
			end
		end
	end
end

addCommandHandler("traervehpub",
	function(player, cmd, faction, placa)
		if permisos[getACLFromPlayer(player)] == true then
			local tablet = Vehicles_s.vehicles[faction] or false
			if tablet then
				local vehicle = tablet[tonumber(placa)]
				if isElement(vehicle.Veh) then
					local position = player.matrix.position + player.matrix.right * 3
					setElementPosition(vehicle.Veh,position.x,position.y,position.z)
					setElementRotation(vehicle.Veh, getElementRotation(player))
					setElementInterior(vehicle.Veh, getElementInterior(player))
					setElementDimension(vehicle.Veh, getElementDimension(player))
					exports['[LS]Notificaciones']:setTextNoti(player, "#00FF00Vehículo de #FFFFFF"..faction.." #00FF00de #FFFFFFID ".. tonumber(placa).."#00FF00 encontrado y enviado.")
				end
			else		
				exports['[LS]Notificaciones']:setTextNoti(player, "Syntax: /traervehpub <clave> <id>")
				exports['[LS]Notificaciones']:setTextNoti(player, "Claves: Mary, ADAM, Louis, LINCON, TAC, TORH, DAVID, DIC, BUS")
			end
		end
	end
)

addEvent('Roleplay:respawnVehPub', true)
addEventHandler('Roleplay:respawnVehPub', root,
	function(toSpawn)
		local placa = toSpawn:getPlateText()
		if placa then
			local faction,id = placa:sub(1,#placa-1):lower(),tonumber(placa:sub(#placa))
			if faction ~= '' and tonumber(id) then
				local tablet = Vehicles_s.vehicles[faction] or false			
				if tablet then
					local vehicle = tablet[id]
					if isElement(vehicle.Veh) then
						vehicle.Veh:respawn()
					end
				end
			end
		end
	end
)


addEventHandler("onVehicleEnter", getRootElement(), function( thePlayer, seat, jacked )
	if thePlayer:getType() == "player" then
		if seat == 0 then
			if thePlayer:getData('Roleplay:faccion') == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:trabajo") == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:Mision") == source:getData("VehiculoPublico") then
			else
				thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())
				source:setEngineState (false)
				source:setLightState(0, 1)
				source:setLightState(1, 1)
				source:setFrozen(true)
				thePlayer:outputChat("Este vehículo le pertenece a "..source:getData("VehiculoPublico").."", 150, 50, 50, true)
				--
			end
		end
	end
end)

addCommandHandler("respawnvehpub",
	function(player, cmd, faction, placa)
		if permisos[getACLFromPlayer(player)] == true then
			if faction ~= 'all' then
				local tablet = Vehicles_s.vehicles[faction] or false
				if tablet then
					local vehicle = tablet[tonumber(placa)]
					if isElement(vehicle.Veh) then
						if isVehicleEmpty( vehicle.Veh ) then
							vehicle.Veh:respawn()
							vehicle.State = true
							vehicle.Veh:setLocked(vehicle.State)
							vehicle.Veh:setEngineState(false)
							setElementData(vehicle.Veh, "Fuel", 100)
							exports['[LS]Notificaciones']:setTextNoti(player, "Vehiculo Respawneado")
						end
					end
				else
					exports['[LS]Notificaciones']:setTextNoti(player, "Syntax: /respawnvehpub all")
					exports['[LS]Notificaciones']:setTextNoti(player, "Syntax: /respawnvehpub <clave> <id>")
					exports['[LS]Notificaciones']:setTextNoti(player, "Claves: Mary, ADAM, Louis, LINCON, TAC, TORH, DAVID, DIC, BUS")
				end
			else
				for _,dd in pairs(Vehicles_s.vehicles) do
					for index,data in pairs(dd) do
						if isVehicleEmpty( data.Veh ) then
							if data.Veh:respawn() then
								data.State = true
								data.Veh:setLocked(data.State)
								data.Veh:setEngineState(false)
								setElementData(data.Veh, "Fuel", 100)
							end
						end
					end
				end
				exports['[LS]Notificaciones']:setTextNoti(Element.getAllByType("player"), "#FFFFFFTodos los #DDFF00vehículos públicos #FFFFFFhan sido respawneados.")
			end
		end
	end
)

function respawnVehJob(faction, placa)
	local tablet = Vehicles_s.vehicles[faction] or false
	if tablet then
		local vehicle = tablet[tonumber(placa)]
		if isElement(vehicle.Veh) then
			if isVehicleEmpty( vehicle.Veh ) then
				vehicle.Veh:respawn()
				vehicle.State = true
				vehicle.Veh:setLocked(vehicle.State)
				vehicle.Veh:setEngineState(false)
				setElementData(vehicle.Veh, "Fuel", 100)
			end
		end
	end
end

addCommandHandler("llenargasevhpub",
	function(player, cmd)
		if permisos[getACLFromPlayer(player)] == true then
			for _,dd in pairs(Vehicles_s.vehicles) do
				for index,data in pairs(dd) do
					setElementData(data.Veh, "Fuel", 100)
				end
			end
			exports['[LS]Notificaciones']:setTextNoti(Element.getAllByType("player"), "#FFFFFFTodos los #DDFF00vehículos públicos #FFFFFFse les ha llenado la gasolina.")
		end
	end
)


addEventHandler( "onResourceStart", getResourceRootElement( ), 
	function()
		for Faction,Info in pairs(Data_Vehicles) do
			for _,datos in ipairs(Info) do
				Vehicles_s:constructor(datos, Faction)
			end
		end
	end
)

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

function isVehicleEmpty( vehicle )
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end

	local passengers = getVehicleMaxPassengers( vehicle )
	if type( passengers ) == 'number' then
		for seat = 0, passengers do
			if getVehicleOccupant( vehicle, seat ) then
				return false
			end
		end
	end
	return true
end

function getPlayersOverArea(player,range)
	local new = {}
	local x, y, z = getElementPosition( player )
	local chatCol = ColShape.Sphere(x, y, z, range)
	new = chatCol:getElementsWithin("player") or {}
	chatCol:destroy()
	return new
end