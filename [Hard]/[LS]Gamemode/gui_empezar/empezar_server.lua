addCommandHandler({"empezar"}, function(p)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			p:triggerEvent("setVisible", p)
		end
	end
end)