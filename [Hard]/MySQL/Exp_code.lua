function getMyCode()
	local my_code = [[
		functions_exports = {}
		functions_exports.__index = functions_exports


		function import(...)
			return functions_exports:new(...)
		end

		function functions_exports:new(functions)
			if #functions == 0 then
				return iprint 'No hay Funciones a Exportar'
			end
			local instance = {functions = functions}
			setmetatable(instance, self)
			return instance
		end

		function functions_exports:init(resource)
			local res = Resource.getFromName(resource)
			if (res) then
				local functions = res:getExportedFunctions()
				if (#functions > 0) then
					local loads = {}
					if self['functions']:find('*') then
						loads = functions
					else
						for k,v in pairs(split(self['functions'],',')) do
							if table.find(functions, v) then
								table.insert(loads, v)
							end
						end
					end
					for i,v in ipairs(loads) do
						_G[v] = function(...) return call(res, v, ...) end
					end
				end
			end
		end

		function table.find(t,value)
			for k,v in pairs(t) do
				if (v == value) then
					return true
				end
			end
			return false
		end
		
		function table.getn(t)
		    local size = 0
		    for _ in pairs(t) do
		        size = size + 1
		    end
		    return size
		end
		]]
	return my_code
end

function getPlayerNearbyVehicle(player)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 6 then
				return veh
			end
		end
	end
	return false
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

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function _getPlayerNameR( name )
	local playerName = name:getName()
	--while true do
		local str = name:getName()
		local find = str:find('_')
		if (find ) then
			local name = str:sub(1,find-1)..' '..str:sub(find+1)
			return name
		end
	--end
	return playerName or ""
end