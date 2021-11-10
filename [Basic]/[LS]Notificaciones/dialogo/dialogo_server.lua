tabla = {
		{"text", "string"},
		{"timer", "tonumber"},
		{"rectangle", "string"},
}
function callCinematic( player, text, timer, rectangle )
	for i, v in ipairs(tabla) do
		if (type(v[1]) ~= v[2]) then
			return false
		end
	end
	triggerClientEvent(player, "callCinematic", resourceRoot, text, timer, rectangle)
	return true
end