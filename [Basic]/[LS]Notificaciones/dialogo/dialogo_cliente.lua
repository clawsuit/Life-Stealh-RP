sx_, sy_ = guiGetScreenSize()
sx, sy = sx_/1360, sy_/768
local cinematic = {}

function callCinematic( text, timer, rectangle )
		table.insert(cinematic, {text, timer, rectangle, getTickCount()})
	--
	if rectangle == "Si" then
		showChat(false)
		setPlayerHudComponentVisible ( "radar", false ) 
		triggerEvent("removeHudPlayer", localPlayer)
	end
	outputConsole ( "[TEXTO-CINEMATIC] "..text )
	for index, v in ipairs(cinematic) do
		if index >= 1 then
			v[1] = text
			v[2] = timer
			v[3] = rectangle
			v[4] = getTickCount()
		end
	end
end
addEvent("callCinematic", true)
addEventHandler("callCinematic", root, callCinematic)

function renderCinamtic()
	for index, v in ipairs(cinematic) do
		if v[3] == "Si" then
			dxDrawRectangle( 0*sx, 0*sy, 1360*sx, 150*sy, tocolor(0, 0, 0, 255), false )
			dxDrawRectangle( 0*sx, 620*sy, 1360*sx, 150*sy, tocolor(0, 0, 0, 255), false )
		end
		--
		dxDrawBorderedText(v[1], 0*sx, 620*sy, 1360*sx + 0*sx, 150*sy + 620*sy, tocolor(255, 255, 255, 255), 0.50, "bankgothic", "center", "center", false, true, false, false, false)
		if getTickCount()-v[2] > v[4] then
			table.remove(cinematic, index)
			setPlayerHudComponentVisible ( "radar", true ) 
			triggerEvent("addhudPlayer", localPlayer)
			showChat(true)
		end
	end
end
addEventHandler("onClientRender", root, renderCinamtic)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) - 1, (w) - 1, (h) - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) - 1, (w) + 1, (h) - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end