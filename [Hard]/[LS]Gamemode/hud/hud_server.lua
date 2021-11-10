addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		v:setData("Roleplay:stamina", 100)
	end
end)

function addhudPlayer(player)
	player:triggerEvent("addhudPlayer", player)
end

function removeHudPlayer(player)
	player:triggerEvent("removeHudPlayer", player)
end