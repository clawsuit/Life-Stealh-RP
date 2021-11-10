local antiBugConducir = false

function RemoverAntiBug()
	if antiBugConducir == false then
		antiBugConducir = true
	else
		antiBugConducir = false
	end
end

local tabla_licencias = {
{"Conducir", 200},
{"Navegar", 2000},
{"Piloto", 10000},
{"Pesca", 100},
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelLicencieros = guiCreateWindow(0.38, 0.23, 0.24, 0.54, "Licencieros", true)
        guiWindowSetSizable(PanelLicencieros, false)
        guiSetVisible(PanelLicencieros, false)
        guiSetAlpha(PanelLicencieros, 1.00)

        LabelLicencieros = guiCreateLabel(0.03, 0.06, 0.94, 0.51, "Bienvenido a Licencieros\naquí podrás obtener una gran variedad de licencias para poder acceder a ciertos trabajos o para poder realizar ciertas acciones de forma legal.\n[ADVERTENCIA]: Los que estan en el color rojo se debe a que no tienes esa licencia, el color verde es porque la tienes.\n\nSelecciona una de la lista y haz click en el boton de Comprar que se situa abajo de la lista para conseguirla. En caso de que tu licencia requiera un examen deberás realizar ciertas acciones. Si pierdes el examen, deberás de volver a pagar para darlo.", true, PanelLicencieros)
        guiLabelSetHorizontalAlign(LabelLicencieros, "center", true)
        guiLabelSetVerticalAlign(LabelLicencieros, "center")
        ListaLicencieros = guiCreateGridList(0.03, 0.59, 0.94, 0.20, true, PanelLicencieros)
        guiGridListAddColumn(ListaLicencieros, "Licencia", 0.3)
        guiGridListAddColumn(ListaLicencieros, "Por 4", 0.3)
        guiGridListAddColumn(ListaLicencieros, "", 0.3)
        boton_conseguir = guiCreateButton(0.27, 0.81, 0.46, 0.07, "Conseguir ..", true, PanelLicencieros)
        guiSetFont(boton_conseguir, "default-bold-small")
        guiSetProperty(boton_conseguir, "NormalTextColour", "FFAAAAAA")
        boton_cerrar = guiCreateButton(0.27, 0.90, 0.46, 0.07, "==Cerrar==", true, PanelLicencieros)
        guiSetFont(boton_cerrar, "default-bold-small")
        guiSetProperty(boton_cerrar, "NormalTextColour", "FFAAAAAA")    
    end
)

addEventHandler("onClientGUIClick", resourceRoot, function()
	local name = guiGridListGetItemText ( ListaLicencieros, guiGridListGetSelectedItem ( ListaLicencieros ), 1 )
	local money = guiGridListGetItemText ( ListaLicencieros, guiGridListGetSelectedItem ( ListaLicencieros ), 2 )
	if source == boton_cerrar then
		guiSetVisible(PanelLicencieros, false)
		showCursor(false)
	elseif source == ListaLicencieros then
		if name ~="" then
			for i, v in ipairs(tabla_licencias) do
				if tostring(name) == tostring(v[1]) then
					guiSetText(boton_conseguir, "Conseguir "..v[1])
				end
			end
		else
			guiSetText(boton_conseguir, "Conseguir ..")
		end
	elseif source == boton_conseguir then
		if name ~="" then
			guiSetVisible(PanelLicencieros, false)
			showCursor(false)
			--
			if name == "Conducir" then
				antiBugConducir = true
				setTimer(RemoverAntiBug, 60*1000, 1)
				triggerServerEvent("startMisionsLicenses", localPlayer, "Conducir", money)
			else
				triggerServerEvent("startMisionsLicenses", localPlayer, tostring(name), money)
			end
		end
	end
end)

addEvent("setPanelLicencieros", true)
addEventHandler("setPanelLicencieros", root, function()
	if antiBugConducir == false then
		if guiGetVisible(PanelLicencieros) == true then
			guiSetVisible(PanelLicencieros, false)
			showCursor(false)
		else
			guiSetVisible(PanelLicencieros, true)
			showCursor(true)
			--
			guiGridListClear(ListaLicencieros)
	        for _, v in ipairs(tabla_licencias) do
	        	local row = guiGridListAddRow(ListaLicencieros)
	        	if v[1] == "Conducir" then
		        	if localPlayer:getData("Roleplay:Licencia_Conducir") == 0 then
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "X", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 150, 50, 50, 255)
		        		end
		        	else
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "✓", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 50, 200, 50, 255)
		        		end
			        end
			    elseif v[1] == "Navegar" then
		        	if localPlayer:getData("Roleplay:Licencia_Navegar") == 0 then
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "X", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 150, 50, 50, 255)
		        		end
		        	else
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "✓", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 50, 200, 50, 255)
		        		end
			        end
			    elseif v[1] == "Piloto" then
		        	if localPlayer:getData("Roleplay:Licencia_Piloto") == 0 then
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "X", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 150, 50, 50, 255)
		        		end
		        	else
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "✓", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 50, 200, 50, 255)
		        		end
			        end
			    elseif v[1] == "Pesca" then
		        	if localPlayer:getData("Roleplay:Licencia_Pesca") == 0 then
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "X", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 150, 50, 50, 255)
		        		end
		        	else
		        		guiGridListSetItemText(ListaLicencieros, row, 1, v[1], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 2, v[2], false, false)
		        		guiGridListSetItemText(ListaLicencieros, row, 3, "✓", false, false)
		        		for i=1,3 do
		        			guiGridListSetItemColor(ListaLicencieros, row, i, 50, 200, 50, 255)
		        		end
			        end
			    end
	        end
		end
	else
		outputChatBox("#FFFF00[Licencieros] #FFFFFFEspera 1 minuto para volver a sacar una licencia.", 255, 255, 255, true)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i, v in pairs( pickups_infos ) do
		p = Pickup( v[1], v[2], v[3], 3, 1239, 0 )
		p:setInterior(v.int)
		p:setDimension(v.dim)
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(pickups_infos) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end