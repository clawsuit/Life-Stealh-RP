loadstring(exports.dgs:dgsImportFunction())()
local r, g, b = 255, 255, 255
local ModShop = {}

local ListaTableModificaciones = {
{"Color Primario"},
{"Color Segundario"},
{"Reparar"},
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        --
        PanelModificaciones = guiCreateWindow(0.01, 0.22, 0.18, 0.56, "Panel de modificación.", true)
        guiWindowSetSizable(PanelModificaciones, false)
        guiSetVisible( PanelModificaciones, false )

        ListaModificaciones = guiCreateGridList(0.04, 0.16, 0.92, 0.72, true, PanelModificaciones)
        guiGridListAddColumn(ListaModificaciones, "", 0.9)
        InfoModificacion = guiCreateLabel(0.04, 0.06, 0.92, 0.09, "Para seleccionar lo que deseas modificar, doble click", true, PanelModificaciones)
        guiSetFont(InfoModificacion, "default-bold-small")
        guiLabelSetHorizontalAlign(InfoModificacion, "center", true)
        guiLabelSetVerticalAlign(InfoModificacion, "center")
        CerrarPanelModificaciones = guiCreateButton(64, 393, 118, 25, "Cerrar", false, PanelModificaciones)
        guiSetProperty(CerrarPanelModificaciones, "NormalTextColour", "FFAAAAAA")    

        --
        PanelColores = guiCreateWindow(0.68, 0.38, 0.31, 0.23, "Escribe los colores", true)
        guiWindowSetSizable(PanelColores, false)
        guiSetVisible( PanelColores, false )

        labelColoresInfo = guiCreateLabel(0.02, 0.13, 0.95, 0.27, "El boton 'test'\nPodrás los R, G, B de los colores que deseas, también puedes escribirlo.", true, PanelColores)
        guiSetFont(labelColoresInfo, "default-bold-small")
        guiLabelSetHorizontalAlign(labelColoresInfo, "center", true)
        guiLabelSetVerticalAlign(labelColoresInfo, "center")
        labelColoresR = guiCreateLabel(0.02, 0.46, 0.08, 0.21, "R:", true, PanelColores)
        guiSetFont(labelColoresR, "default-bold-small")
        guiLabelSetHorizontalAlign(labelColoresR, "center", true)
        guiLabelSetVerticalAlign(labelColoresR, "center")
        labelColoresG = guiCreateLabel(0.35, 0.46, 0.08, 0.21, "G:", true, PanelColores)
        guiSetFont(labelColoresG, "default-bold-small")
        guiLabelSetHorizontalAlign(labelColoresG, "center", true)
        guiLabelSetVerticalAlign(labelColoresG, "center")
        labelColoresB = guiCreateLabel(0.72, 0.46, 0.08, 0.21, "B:", true, PanelColores)
        guiSetFont(labelColoresB, "default-bold-small")
        guiLabelSetHorizontalAlign(labelColoresB, "center", true)
        guiLabelSetVerticalAlign(labelColoresB, "center")
        editColoresR = guiCreateEdit(0.13, 0.46, 0.16, 0.21, "255", true, PanelColores)
        guiEditSetMaxLength(editColoresR, 3)
        editColoresG = guiCreateEdit(0.45, 0.46, 0.16, 0.21, "255", true, PanelColores)
        guiEditSetMaxLength(editColoresG, 3)
        editColoresB = guiCreateEdit(0.82, 0.46, 0.16, 0.21, "255", true, PanelColores)
        guiEditSetMaxLength(editColoresB, 3)
        botonConfirmarColor = guiCreateButton(0.05, 0.72, 0.36, 0.22, "Confirmar", true, PanelColores)
        guiSetFont(botonConfirmarColor, "default-bold-small")
        guiSetProperty(botonConfirmarColor, "NormalTextColour", "FFAAAAAA")
        botonCancelarColor = guiCreateButton(0.60, 0.72, 0.36, 0.22, "Cancelar", true, PanelColores)
        guiSetFont(botonCancelarColor, "default-bold-small")
        guiSetProperty(botonCancelarColor, "NormalTextColour", "FFAAAAAA")
        botonTestColor = guiCreateButton(0.43, 0.72, 0.14, 0.22, "Test", true, PanelColores)
        guiSetFont(botonTestColor, "default-small")
        guiSetProperty(botonTestColor, "NormalTextColour", "FFAAAAAA")    

        --
        colorPicker = dgsCreateColorPicker("HSVRing",0.80, 0.10, 0.15, 0.20,true)
        dgsSetVisible(colorPicker, false)
        addEventHandler("onDgsColorPickerChange",colorPicker,function()
            local rt,gt,bt,axd = dgsColorPickerGetColor(colorPicker,"RGB")
            r = rt
            g = gt
            b = bt
            guiLabelSetColor( labelColoresInfo, r, g, b )
            --
            guiSetText(editColoresR, r);guiSetText(editColoresG, g);guiSetText( editColoresB, b )
        end,false)
    end
)

addEventHandler("onClientGUIChanged", root, function()
    if source == editColoresR or source == editColoresG or source == editColoresB then
        local currText = guiGetText(source)
        local newText = string.gsub(currText, "[^0-9]", "")
        if newText ~= currText then
            print(newText)
            guiSetText(source, newText)
        end
    end
    if source == editColoresR then
        local RT = guiGetText( source )
        r = tonumber(RT)
    elseif source == editColoresG then
        local GT = guiGetText( source )
        g = tonumber(GT)
    elseif source == editColoresB then
        local BT = guiGetText( source )
        b = tonumber(BT)
    end
    guiLabelSetColor( labelColoresInfo, r, g, b )
end)

local colorPri = 1

addEventHandler("onClientGUIClick", resourceRoot, function()
    if source == CerrarPanelModificaciones then
        if guiGetVisible( PanelModificaciones ) == true then
            guiSetVisible(PanelModificaciones, false)
            showCursor(false)
            triggerServerEvent("MarkerFixedModification", localPlayer)
        end
        if guiGetVisible( PanelColores ) == true then
            guiSetVisible(PanelColores, false)
        end
        if dgsGetVisible(colorPicker) == true then
            dgsSetVisible(colorPicker, false)
        end
    elseif source == botonConfirmarColor then
        if localPlayer:getMoney() >= 300 then
            local r, g, b = guiGetText( editColoresR ), guiGetText( editColoresG ), guiGetText( editColoresB )
            triggerServerEvent("changeColorVeh", localPlayer, colorPri, r, g, b)
            if guiGetVisible( PanelColores ) == true then
                guiSetVisible(PanelColores, false)
            end
            if dgsGetVisible(colorPicker) == true then
                dgsSetVisible(colorPicker, false)
            end
        else
            triggerEvent("callCinematic", localPlayer,"#FF0033No tienes suficiente dinero.", 5000, "No")
        end
    elseif source == botonCancelarColor then
        if guiGetVisible( PanelColores ) == true then
            guiSetVisible(PanelColores, false)
        end
        if dgsGetVisible(colorPicker) == true then
            dgsSetVisible(colorPicker, false)
        end
    elseif source == botonTestColor then
        if dgsGetVisible(colorPicker) == false then
            dgsSetVisible( colorPicker, true )
        else
            dgsSetVisible(colorPicker, false)
        end
    end
end)
--
addEventHandler("onClientGUIDoubleClick", resourceRoot, function()
    local mod = guiGridListGetItemText ( ListaModificaciones, guiGridListGetSelectedItem ( ListaModificaciones ), 1 )
    if source == ListaModificaciones then
        if mod ~="" then
            if mod == "Color Primario" then
            	colorPri = 1
                if guiGetVisible( PanelColores ) == false then
                    guiSetVisible(PanelColores, true)
                end
            elseif mod == "Color Segundario" then
            	colorPri = 2
            	r, g, b = 255, 255, 255
            	guiSetText(editColoresR, r);guiSetText(editColoresG, g);guiSetText( editColoresB, b )
            	guiLabelSetColor( labelColoresInfo, r, g, b )
                if guiGetVisible( PanelColores ) == false then
                    guiSetVisible(PanelColores, true)
                end
            end
        end
    end
end)
--
addEvent("ModShop:guiOpen", true)
function ModShop.guiOpen()
    if guiGetVisible( PanelModificaciones ) == true then
        guiSetVisible(PanelModificaciones, false)
        showCursor(false)
        if guiGetVisible( PanelColores ) == true then
            guiSetVisible(PanelColores, false)
        end
        if dgsGetVisible(colorPicker) == true then
            dgsSetVisible(colorPicker, false)
        end
    else
        guiSetVisible(PanelModificaciones, true)
        showCursor(true)
        --
        guiGridListClear( ListaModificaciones )
        for _, v in ipairs(ListaTableModificaciones) do
            local row = guiGridListAddRow( ListaModificaciones )
            guiGridListSetSortingEnabled ( ListaModificaciones, false )
            guiGridListSetItemText(ListaModificaciones, row, 1, v[1], false, false)
        end
    end
end
addEventHandler("ModShop:guiOpen", root, ModShop.guiOpen)