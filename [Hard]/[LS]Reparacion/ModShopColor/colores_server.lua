local DatMarkerColor = {}
local MarkerDataID = {}

local PaintJobVehs = {
[483] = true,
[534] = true,
[535] = true,
[536] = true,
[558] = true,
[559] = true,
[560] = true,
[561] = true,
[562] = true,
[565] = true,
[567] = true,
[575] = true,
[576] = true,
}
--
local componets = {
"health",
"armour",
"weapon",
}

addEvent("changeColorVeh", true)
addEventHandler("changeColorVeh", root, function(tip, r, g, b)
	local veh = source:getOccupiedVehicle()
	local seat = source:getOccupiedVehicleSeat()
	if source:isInVehicle() then
		if veh and seat == 0 then
--[[
			local color = ""
			for i, v in pairs(getDato(source, "TunningColorVeh")) do
				if color == "" then
					color = v
				else
					color = color..","..v
				end
			end
]]
			local c = getDato(source, "TunningColorVeh")
			local r1, g1, b1, r2, g2, b2 = c[1], c[2], c[3], c[4], c[5], c[6]
			if tip == 1 then
				setVehicleColor(veh, r, g, b, r2, g2, b2)
				setDato(source, "TunningColorVeh", {r, g, b, r2, g2, b2}, true)
				source:triggerEvent("callCinematic", source,"Tu vehículo ha sido cambiado de color\nsatisfactoriamente\nCosto de: #004500$ 300 dólares.", 5000, "No")
			elseif tip == 2 then
				setVehicleColor(veh, r1, g1, b1, r, g, b)
				setDato(source, "TunningColorVeh", {r1, g1, b1, r, g, b}, true)
				source:triggerEvent("callCinematic", source,"Tu vehículo ha sido cambiado de color\nsatisfactoriamente\nCosto de: #004500$ 300 dólares.", 5000, "No")
			end
		end
	end
end)

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getMarkersColors()) do
		DatMarkerColor[i] = Marker(v.Posiciones[1], v.Posiciones[2], v.Posiciones[3]-1, "cylinder", 3, 50, 70, 80, 50)
		setDato(DatMarkerColor[i], "TunningModification", {v.ID, false, ""}, true)
		--
		addEventHandler("onMarkerHit", DatMarkerColor[i], function(hitElement)
			if isElement(hitElement) and hitElement:getType() == "player" then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if hitElement:isInVehicle() then
					if veh and seat == 0 then
						local id = getDato(source, "TunningModification")[1]
						local hit = getDato(source, "TunningModification")[2]
						local p = getDato(source, "TunningModification")[3]
						local r, g, b, r2, g2, b2 = getVehicleColor(veh, true)
						if hit == false then
							hitElement:triggerEvent("ModShop:guiOpen", hitElement)
							hitElement:triggerEvent("removeHudPlayer", hitElement)
							source:setAlpha(30)
							for _, v in pairs(componets) do
								--hitElement:setHudComponentVisible(v, false)
							end
							print(r, g, b, r2, g2, b2)
							setDato(hitElement, "TunningColorVeh", {r, g, b, r2, g2, b2}, true)
							setDato(source, "TunningModification", {id, true, hitElement:getName()}, true)
						end
					end
				end
			end
		end)
		--
		addEventHandler("onMarkerLeave", DatMarkerColor[i], function(hitElement)
			if isElement(hitElement) and hitElement:getType() == "player" then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if hitElement:isInVehicle() then
					if veh and seat == 0 then
						local id = getDato(source, "TunningModification")[1]
						local hit = getDato(source, "TunningModification")[2]
						local p = getDato(source, "TunningModification")[3]
						if hitElement:getName() == p then
							if hit == true then
								source:setAlpha(50)
								for _, v in pairs(componets) do
									--hitElement:setHudComponentVisible(v, true)
								end
								hitElement:triggerEvent("ModShop:guiOpen", hitElement)
								hitElement:triggerEvent("addhudPlayer", hitElement)
								setDato(source, "TunningModification", {id, false, ""}, true)
								setDato(hitElement, "TunningColorVeh", {}, true)
							end
						end
					end
				end
			end
		end)
	end
end)
--
addEvent("MarkerFixedModification", true)
function MarkerFixedModification()
	for i, v in ipairs(DatMarkerColor) do
		if source:isWithinMarker(v) then
			local id = getDato(v, "TunningModification")[1]
			local hit = getDato(v, "TunningModification")[2]
			local p = getDato(v, "TunningModification")[3]
			if source:getName() == p then
				if hit == true then
					v:setAlpha(50)
					source:triggerEvent("addhudPlayer", source)
					for _, v in pairs(componets) do
						--source:setHudComponentVisible(v, true)
					end
					setDato(v, "TunningModification", {id, false, ""}, true)
					setDato(source, "TunningColorVeh", {}, true)
				end
			end
		end
	end
end
addEventHandler("MarkerFixedModification", root, MarkerFixedModification)
--fixbug
addEventHandler("onPlayerQuit", getRootElement(), function()
	for i, v in ipairs(DatMarkerColor) do
		if source:isWithinMarker(v) then
			local id = getDato(v, "TunningModification")[1]
			local hit = getDato(v, "TunningModification")[2]
			local p = getDato(v, "TunningModification")[3]
			if source:getName() == p then
				if hit == true then
					v:setAlpha(50)
					setDato(v, "TunningModification", {id, false, ""}, true)
					setDato(source, "TunningColorVeh", {}, true)
				end
			end
		end
	end
end)