local ArmasTable = {
{22, "Pistola 9mm", 1000, "Pistola + 17 balas", 17},
{24, "Desert Eagle .44", 3000, "Pistola + 7 balas", 7},
{25, "Escopeta Remington", 4000, "Escopeta + 7 balas", 7},
{33, "Rifle de Caza", 7950, "Rifle + 10 balas", 10},
{29, "Subfusil MP5", 8150, "Subfusil + 30 balas", 30},
{31, "Fusil M4A1", 25150, "Fusil + 30 balas", 30},
{0, "Chaleco", 250, "+50 de chaleco antibalas", 50},
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelArmas = guiCreateWindow(0.33, 0.29, 0.33, 0.42, "Click aquí para cerrar esto.", true)
        guiWindowSetSizable(PanelArmas, false)
        guiSetVisible(PanelArmas, false)
		 guiSetAlpha(PanelArmas, 0.80)

        LabelWeapon = guiCreateLabel(0.02, 0.07, 0.96, 0.09, "Selecciona una de la lista y dale en 'comprar'", true, PanelArmas)
        guiSetFont(LabelWeapon, "default-bold-small")
        guiLabelSetHorizontalAlign(LabelWeapon, "center", true)
        guiLabelSetVerticalAlign(LabelWeapon, "center")
        ListaArmas = guiCreateGridList(0.04, 0.18, 0.93, 0.71, true, PanelArmas)
        guiGridListAddColumn(ListaArmas, "", 0.3)
        guiGridListAddColumn(ListaArmas, "$ Costo", 0.3)
        guiGridListAddColumn(ListaArmas, "Descripción", 0.3)
        botonComprarArma = guiCreateButton(0.37, 0.91, 0.25, 0.07, "Comprar", true, PanelArmas)
        guiSetProperty(botonComprarArma, "NormalTextColour", "FFAAAAAA")    
    end
)

addEventHandler("onClientGUIClick", resourceRoot, function()
    local id = guiGridListGetItemData( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 1 )
    local itenName = guiGridListGetItemText ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 1 )
    local costo = guiGridListGetItemData ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 2 )
    local descripcion = guiGridListGetItemText ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 3 )
    local valor = guiGridListGetItemData ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 3 )
    if source == PanelArmas then
        setVisible(PanelArmas)
    elseif source == botonComprarArma then
        setEnabled(botonComprarArma, 2000)
        if itenName ~="" then
           triggerServerEvent("buyWeapon", localPlayer, id, itenName, costo, descripcion, valor)
        end
    end
end)

addEvent("Armas:setWindow", true)
addEventHandler("Armas:setWindow", root, function( )
    setVisible(PanelArmas)
    --
    guiGridListClear( ListaArmas )
    --
    for i, v in ipairs(ArmasTable) do
        local row = guiGridListAddRow( ListaArmas )
        guiGridListSetItemText(ListaArmas, row, 1, v[2], false, true)
        guiGridListSetItemText(ListaArmas, row, 2, "$"..v[3], false, true)
        guiGridListSetItemText(ListaArmas, row, 3, v[4], false, true)
        --
        guiGridListSetItemData( ListaArmas, row, 1, v[1] )
        guiGridListSetItemData( ListaArmas, row, 2, v[3] )
        guiGridListSetItemData( ListaArmas, row, 3, v[5] )
    end
end)