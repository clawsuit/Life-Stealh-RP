local antiSpamYO = {}
local antiSpamGuardarYO = {}
local valoresYo = {}

function describir_personaje( source, cmd, ... )
	if not source:getAccount():isGuest () then
		local tick = getTickCount()
		if (antiSpamYO[source] and antiSpamYO[source][1] and tick - antiSpamYO[source][1] < 2000) then
			source:outputChat("Espera 2 segundos para volver utilizar el comando ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			source:setData("yo", {message, 150, 0, 0})
			if (not antiSpamYO[source]) then
				antiSpamYO[source] = {}
			end
			antiSpamYO[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			source:setData("yo", {"", 150, 0, 0})
		end
	end
end
addCommandHandler({"yo"}, describir_personaje)

function guardar_yo( source, cmd )
	if not source:getAccount():isGuest () then
		local tick = getTickCount()
		if (antiSpamGuardarYO[source] and antiSpamGuardarYO[source][1] and tick - antiSpamGuardarYO[source][1] < 5000) then
			source:outputChat("Espera 2 segundos para volver utilizar el comando ", 150, 0, 0)
			return
		end
		--
		source:outputChat("* El /yo ha sido guardado", 30, 100, 30, true)
		if isPlayerExists(valoresYo, source) then
			for i, v in ipairs(valoresYo) do
				if AccountName(source) == v[1] then
					v[2] = source:getData("yo")[1]
				end
			end
		else
			table.insert(valoresYo, { AccountName(source), source:getData("yo")[1], 150, 0, 0})
		end
		--
		if (not antiSpamGuardarYO[source]) then
			antiSpamGuardarYO[source] = {}
		end
		antiSpamGuardarYO[source][1] = getTickCount()
	end
end
addCommandHandler({"guardaryo"}, guardar_yo)

addEventHandler("onPlayerLogin", getRootElement(), function()
	if isPlayerExists(valoresYo, source) then
		for i, v in ipairs(valoresYo) do 
			if AccountName(source) == v[1] then
				source:setData("yo", {v[2], v[3], v[4], v[5]})
			end
		end
	end
end)

function isPlayerExists(tabla, player)
	for _, v in ipairs (tabla) do
		if v[1] == AccountName(player) then
			return true
		end
	end
	return false
end

addEventHandler("onPlayerJoin", getRootElement(), function()
	source:setData("yo", {"", 150, 0, 0})
end)