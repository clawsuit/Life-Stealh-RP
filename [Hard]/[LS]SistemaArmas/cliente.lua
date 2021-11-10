
windowArmas = guiCreateWindow(0.36, 0.19, 0.27, 0.65, "Armas - Policía", true)
guiWindowSetSizable(windowArmas, false)
guiSetVisible(windowArmas,false)

cerrarX = guiCreateLabel( 0.80, 0.005, 0.20, 0.04, 'Cerrar', true, windowArmas )
guiSetFont(cerrarX, "default-bold-small")
guiSetProperty(cerrarX, "ClippedByParent", "False")
guiSetProperty(cerrarX, "AlwaysOnTop", "True")
guiSetProperty(cerrarX, "RiseOnClick", "False")
GuardarArmas = guiCreateButton(0.50, 0.12, 0.47, 0.08, "Guardar Armas", true, windowArmas)
TomarArmasGuardadas = guiCreateButton(0.50, 0.21, 0.47, 0.08, "Tomar Armas guardado", true, windowArmas)
ListaArmas = guiCreateGridList(0.04, 0.31, 0.46, 0.65, true, windowArmas)
guiGridListAddColumn(ListaArmas, "Armas", 0.84)
TomarArmas = guiCreateButton(0.55, 0.69, 0.38, 0.15, "Tomar Arma", true, windowArmas)

local cadetes = {
{"Porra", 3, 1},
{"Deagle", 24, 17},
{"9mm", 30, 30},
--
}

local oficiales = {
{"Porra", 3, 1},
{"Deagle", 24, 17},
{"9mm", 30, 30},
{"MP5", 29, 30},
{"Escopeta", 25, 17},
}

local swat = {
{"Porra", 3, 1},
{"Deagle", 24, 17},
{"9mm", 30, 30},
{"MP5", 29, 30},
{"Escopeta", 25, 17},
{"M4A1", 31, 50},
{"Teargas", 17, 10},
{"Minigun", 38, 100},
}

addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == cerrarX then
		if guiGetVisible(windowArmas) == true then
			guiSetVisible(windowArmas, false)
			showCursor(false)
		end
	end
end)

addEvent("OpenWindow", true)
addEventHandler("OpenWindow", root, function()
	if guiGetVisible(windowArmas) == true then
		guiSetVisible(windowArmas, false)
		showCursor(false)
	else
		guiSetVisible(windowArmas, true)
		showCursor(true)
		--
		if localPlayer:getData('Roleplay:faccion_division') == 'S.W.A.T' or localPlayer:getData('Roleplay:faccion_rango') == 'Comandante' then
			for i, v in ipairs(swat) do
				local row = guiGridListAddRow(ListaArmas)
				guiGridListSetItemText(ListaArmas, row, 1, v[1], false, true)
				guiGridListSetItemData( ListaArmas, row, 1, {v[2], v[3]} )
			end
		elseif localPlayer:getData('Roleplay:faccion_rango') == 'Oficial I' or localPlayer:getData('Roleplay:faccion_rango') == 'Oficial III' or localPlayer:getData('Roleplay:faccion_rango') == 'Oficial II' or localPlayer:getData('Roleplay:faccion_rango') == 'Sargento I' or localPlayer:getData('Roleplay:faccion_rango') == 'Sargento II' or localPlayer:getData('Roleplay:faccion_rango') == 'General' or localPlayer:getData('Roleplay:faccion_rango') == 'Teniente' then
			for i, v in ipairs(oficiales) do
				local row = guiGridListAddRow(ListaArmas)
				guiGridListSetItemText(ListaArmas, row, 1, v[1], false, true)
				guiGridListSetItemData( ListaArmas, row, 1, {v[2], v[3]} )
			end
		elseif localPlayer:getData('Roleplay:faccion_rango') == 'Cadete' then
			for i, v in ipairs(cadetes) do
				local row = guiGridListAddRow(ListaArmas)
				guiGridListSetItemText(ListaArmas, row, 1, v[1], false, true)
				guiGridListSetItemData( ListaArmas, row, 1, {v[2], v[3]} )
			end
		end
	end
end)



addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(266.91845703125, 118.68565368652, 1004.6171875, 0, true )
		local dist = getDistanceBetweenPoints3D( 266.91845703125, 118.68565368652, 1004.6171875, getElementPosition(localPlayer) )

		if x and dist <= 10 then
			x = x - (dxGetTextWidth( '/armas', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('/armas', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/armas', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/armas', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)