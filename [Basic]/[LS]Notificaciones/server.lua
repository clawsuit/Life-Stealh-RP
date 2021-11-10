tabla = {
		{"info", "string"},
		{"texto", "string"},
		{"log", "boolean"},
}
function callNotification( player, info, texto, log )
	for i, v in ipairs(tabla) do
		if (type(v[1]) ~= v[2]) then
			return false
		end
	end
	triggerClientEvent(player, "callNotification", resourceRoot, info, texto, log)
	return true
end