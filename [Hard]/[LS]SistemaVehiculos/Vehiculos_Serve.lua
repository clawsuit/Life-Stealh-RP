loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local blips = {
{1232.8641357422, -1656.9112548828, 11.796875},
{550.77178955078, -1274.2222900391, 17.248237609863},
{998.44769287109, -1301.5908203125, 13.389896392822},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(blips) do
		Blip( v[1], v[2], v[3], 55, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
	end
end)
-- kilometraje
setTimer(function()
	for _, player in ipairs(Element.getAllByType("player")) do
		if player:isInVehicle() then
			local veh = player:getOccupiedVehicle()
			local seat = player:getOccupiedVehicleSeat()
			local acc = veh:getData("Owner")
			if seat == 0 and AccountName(player) == tostring(acc) then
				if getControlState(player, "accelerate") == true or getControlState(player, "brake_reverse") == true then
					local id = veh:getData("ID")
					local kmh = veh:getData("Kilometraje")
					veh:setData("kilometraje", veh:getData("Kilometraje") + 1)
				end
			end
		end
	end
end, 1000, 0)