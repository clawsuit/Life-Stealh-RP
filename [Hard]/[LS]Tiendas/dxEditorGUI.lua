local Items = {}

local screenW, screenH = guiGetScreenSize()

addEventHandler( "onClientResourceStart", resourceRoot, function()
	wndInv = guiCreateWindow((screenW - 216) / 2, (screenH - 318) / 2, 216, 318, "Inventario", false)
	guiWindowSetSizable(wndInv, false)
	guiSetVisible( wndInv, false )

	gridObj = guiCreateGridList(9, 24, 199, 212, false, wndInv)
	guiGridListAddColumn(gridObj, "Objeto", 0.5)
	guiGridListAddColumn(gridObj, "Cantidad", 0.5)
	botUsar = guiCreateButton(9, 246, 198, 27, "Usar", false, wndInv)
	botTirar = guiCreateButton(9, 279, 198, 27, "Tirar", false, wndInv)
	guiSetProperty(botUsar, "NormalTextColour", "FFAAAAAA")
end)

addEvent( 'Open:Inventory', true)
addEventHandler( 'Open:Inventory', getLocalPlayer(  ), 
	function(t,rr)
		if not localPlayer:getData("EnEdicion") then
			if rr == 'refresh' then
				Items.refresh(t)
				return 
			end
			if not guiGetVisible( wndInv ) then
				guiSetVisible( wndInv, true )
				showCursor( true )
				Items.refresh(t)
			else
				guiSetVisible( wndInv, not true )
				showCursor( not true )
			end
		end
	end
)

--localPlayer:setData('Items',false)

function Items.refresh(t)
	guiGridListClear( gridObj )
	if t then
		for k,v in pairs(t) do
			local row = guiGridListAddRow( gridObj )
			guiGridListSetItemText( gridObj, row, 1, v.Item,false,false )
			guiGridListSetItemText( gridObj, row, 2,''..v.Value, false,false)
		end
	end
end


function Items.buttons(b)
	if (b ~= 'left') then return end
	if (source == botUsar) then
		local object,quantity = guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 1 ),guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 2 ) 
		if object ~= "" and quantity ~= "" then
			triggerServerEvent('Refresh:Inventory', localPlayer, object,quantity)
			setEnabled(botUsar, 5000)

			if object == 'Bidon de Gasolina' then
				guiSetVisible( wndInv, not true )
				showCursor( not true )
			end
		end
	elseif (source == botTirar) then
		local object,quantity = guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 1 ),guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 2 ) 
		if object ~= "" and quantity ~= "" then
			triggerServerEvent('TiraItem:Inventory', localPlayer, object,quantity)
		end
	end
end
addEventHandler('onClientGUIClick',resourceRoot,Items.buttons)

addEventHandler("onClientRender", getRootElement(), function()
	for k, v in ipairs(getElementsByType("pickup")) do
		local pick = v:getData("pickup.infoshops")
		if pick then
			tx, ty, tz = getElementPosition( v )
			local px, py, pz = getElementPosition(localPlayer)
			dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			if dist < 8 then
				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
					local sx, sy, sz = getElementPosition( v )
					local x, y = getScreenFromWorldPosition( sx, sy, sz)
					if x and y then
						dxDrawBorderedText ( "Usa la tecla '#FDCE61F#FFFFFF' para interactuar\n#FDCE61"..(pick or "").."", x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 255, 255, 255, 255 ),1, "default-bold","center", "center" )
					end
				end
			end
		end
	end
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
--
local SonidoPlayer = {}
--
addEvent("SoundsPhone", true)
addEventHandler("SoundsPhone", root, function(tip, jugador)
	if tip == "LlamarSound" then
		s = Sound("sounds/LlamarSound.mp3", true)
		s:setVolume(0.50)
	elseif tip == "LlamadaSound" then
		local x, y, z = getElementPosition( jugador )
		SonidoPlayer[jugador] = Sound3D("sounds/LlamadaSound.mp3", x, y, z, true)
		attachElements( jugador, SonidoPlayer[jugador])
		SonidoPlayer[jugador]:setVolume(0.50)
		setSoundMaxDistance(SonidoPlayer[jugador], 10)
	elseif tip == "stopLlamada" then
		stopSound(s)
	elseif tip == "stopLlamado" then
		if SonidoPlayer[jugador] then
			stopSound(SonidoPlayer[jugador])
			SonidoPlayer[jugador] = nil
		end
	end
end)

