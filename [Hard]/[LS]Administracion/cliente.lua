
GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(0.33, 0.25, 0.35, 0.50, "", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[1], false)

        GUIEditor.button[1] = guiCreateButton(192, 342, 91, 29, "X", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
        GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.06, 0.96, 0.81, true, GUIEditor.window[1])   
        guiGridListAddColumn(GUIEditor.gridlist[1], "Cantidad", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[1], "", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[1], "Fecha", 0.3)  
    end
)

addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == GUIEditor.button[1] then
        guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
		guiSetText(GUIEditor.window[1], "")
	end
end)
addEvent("setVisibl", true)
addEventHandler("setVisibl", root, function(typ, s, thePlayer)
	if guiGetVisible(GUIEditor.window[1]) == true then
		guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
	else
		guiSetText(GUIEditor.window[1], "["..typ.."] Log de "..thePlayer:getName())
		if typ:find("Banco") then
			for i, v in ipairs(s) do
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v.Cantidad, false, false)
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, v.Valor, false, false)
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 3, v.Fecha, false, false)
				if v.Valor == "Deposito" then
					for i=1,3 do
						guiGridListSetItemColor( GUIEditor.gridlist[1], row, i, 50, 150, 50, 255 )
					end
				else
					for i=1,3 do
						guiGridListSetItemColor( GUIEditor.gridlist[1], row, i, 150, 50, 50, 255 )
					end
				end
			end
		end
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
	end
end)


--loadstring(exports["[LS]NewData"]:getMyCode())()
--import('getDato,setDato,getDatos'):init('[LS]NewData')

local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768

addEventHandler("onClientRender", getRootElement(), function()
	local time = localPlayer:getData("JailOOC") or 0
	if time and tonumber(time) >= 1 then
		dxDrawBorderedText2("Tiempo Restante: "..time.." segundos", 600*sx, 700*sy, 180*sx + 600*sx, 40*sy + 700*sy, tocolor(255, 255, 255, 120), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
	end
end)

function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
