

Camionero = {

	LugaresDeTrabajo = {
		{2182.2109375, -2253.0424804688, 14.7734375, int=0, dim=0, "/trabajar | /renunciar | /infocamionero\n#5B360F* Camionero"},
	},

	picksCreados = {},

	trailers = {584,435,450,591},

	LugaresCarga = {
		{2130.515625, -2146.7553710938, 13.546875},
	},

	LugaresDescarga = {
		{2107.5236816406, -2086.4743652344, 13.554370880127},
	}
}





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


function dxDrawBourdeText(lines, text, x, y, sx, sy, color, color2, size, font, alignX, alignY,clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	local lines = lines or 2

	for i= -lines, lines, lines do
		for j= -lines, lines, lines do
			dxDrawText( text:gsub('#%x%x%x%x%x%x',''), x + i, y + j, sx + i, sy + j, color2, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		
		end
	end
	dxDrawText( text, x, y, sx, sy, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

--setClipboard( table.concat({getElementRotation(getPedOccupiedVehicle( localPlayer ))},', ') )

function table.ramdom(t,type)

	if type == 'v' then
		return t[math.random(#t)]
	elseif type == 'k' then

		local new = {}

		for k in pairs(t) do
			table.insert(new,k)
		end

		return new[math.random(#new)]
	end
end

function table.create(keys, vals)
	local result = {}
	if type(vals) == 'table' then
		for i,k in ipairs(keys) do
			result[k] = vals[i]
		end
	else
		for i,k in ipairs(keys) do
			result[k] = vals
		end
	end
	return result
end


function newEvent(eventName, ...)
	addEvent(eventName, true)
	addEventHandler(eventName, ...)
end
