
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelComidas = guiCreateWindow(0.33, 0.29, 0.33, 0.42, "Click aquí para cerrar esto.", true)
        guiWindowSetSizable(PanelComidas, false)
        guiSetVisible(PanelComidas, false)
		 guiSetAlpha(PanelComidas, 0.80)

        LabelComida = guiCreateLabel(0.02, 0.07, 0.96, 0.09, "Selecciona una de la lista y dale en 'comprar'", true, PanelComidas)
        guiSetFont(LabelComida, "default-bold-small")
        guiLabelSetHorizontalAlign(LabelComida, "center", true)
        guiLabelSetVerticalAlign(LabelComida, "center")
        ListaComidas = guiCreateGridList(0.04, 0.18, 0.93, 0.71, true, PanelComidas)
        guiGridListAddColumn(ListaComidas, "", 0.5)
        guiGridListAddColumn(ListaComidas, "$ Costo", 0.5)
        botonComprarComida = guiCreateButton(0.37, 0.91, 0.25, 0.07, "Comprar", true, PanelComidas)
        guiSetProperty(botonComprarComida, "NormalTextColour", "FFAAAAAA")    
    end
)

addEventHandler("onClientGUIClick", resourceRoot, function()
	local itemName = guiGridListGetItemText ( ListaComidas, guiGridListGetSelectedItem ( ListaComidas ), 1 )
	local costo = guiGridListGetItemText ( ListaComidas, guiGridListGetSelectedItem ( ListaComidas ), 2 )
	if source == PanelComidas then
		setVisible(PanelComidas)
	elseif source == botonComprarComida then
		setEnabled(botonComprarComida, 2000)
		if itemName ~="" then
			triggerServerEvent("BuyItem", localPlayer, itemName, costo)
		end
	end
end)

local items = { 
{"Telefono", 100},
{"Agenda", 20},
{"Camara", 120},
{"Cuchillo de Caza (Arma)", 200},
{"Bidon Vacio", 250},
{"Lata de Spray", 75},
{"Pizzeta", 200},
{"Pizza Chica", 20},
{"Pizza Grande", 30},
--
{"Pata de Pollo", 10},
{"Hamb. de Pollo", 20},
{"Pollo Asado", 30},
--
{"Cerveza", 20},
{"Agua", 50},
{"Caja de Cigarros", 50},
{"Encendedor", 25},
--
{"Hamburguesa", 10},
{"Hamburguesa Chica", 20},
{"Hamburguesa Grande", 30},
}

addEvent("Comidas:setWindow", true)
addEventHandler("Comidas:setWindow", root, function( tab )
	setVisible(PanelComidas)
	guiGridListClear( ListaComidas )
	for i, v in ipairs( tab ) do
		local row = guiGridListAddRow(ListaComidas)
		guiGridListSetItemText( ListaComidas, row, 1, v, false, true )
		for index, valor in ipairs( items ) do
			if valor[1] == v then
				guiGridListSetItemText( ListaComidas, row, 2, tonumber(valor[2]), false, true )
			end
		end
	end
end)

function setEnabled( var, timer )
	guiSetEnabled( var, false )
	setTimer(guiSetEnabled, timer, 1, var, true)
end

function setVisible( var )
	if guiGetVisible( var ) == true then
		guiSetVisible(var, false)
		showCursor(false)
		guiSetInputEnabled(false)
	else
		guiSetVisible(var, true)
		showCursor(true)
		guiSetInputEnabled(true)
	end
end