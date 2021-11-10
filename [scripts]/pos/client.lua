addEventHandler("onClientResourceStart", resourceRoot,
    function()
        panel_pos = guiCreateWindow(0.31, 0.35, 0.35, 0.37, "Posicion", true)
        guiWindowSetSizable(panel_pos, false)
		guiSetVisible(panel_pos, false)

        edit_pos = guiCreateEdit(0.02, 0.19, 0.75, 0.09, "", true, panel_pos)
        guiEditSetReadOnly(edit_pos, true)
        sacar_pos = guiCreateButton(0.79, 0.19, 0.19, 0.08, "Sacar", true, panel_pos)
        guiSetFont(sacar_pos, "default-bold-small")
        guiSetProperty(sacar_pos, "NormalTextColour", "FFAAAAAA")
        label_pos = guiCreateLabel(0.02, 0.07, 0.96, 0.08, "Sacar Posición X, Y, Z", true, panel_pos)
        guiSetFont(label_pos, "default-bold-small")
        guiLabelSetHorizontalAlign(label_pos, "center", true)
        copy_pos = guiCreateButton(0.79, 0.30, 0.19, 0.08, "Copy", true, panel_pos)
        guiSetFont(copy_pos, "default-bold-small")
        guiSetProperty(copy_pos, "NormalTextColour", "FFAAAAAA")
        label_rot = guiCreateLabel(0.02, 0.41, 0.96, 0.08, "Sacar Rotación X, Y, Z", true, panel_pos)
        guiSetFont(label_rot, "default-bold-small")
        guiLabelSetHorizontalAlign(label_rot, "center", true)
        edit_rot = guiCreateEdit(0.02, 0.53, 0.75, 0.09, "", true, panel_pos)
        guiEditSetReadOnly(edit_rot, true)
        sacar_rotation = guiCreateButton(0.79, 0.53, 0.19, 0.08, "Sacar", true, panel_pos)
        guiSetFont(sacar_rotation, "default-bold-small")
        guiSetProperty(sacar_rotation, "NormalTextColour", "FFAAAAAA")
        copy_rot = guiCreateButton(0.79, 0.64, 0.19, 0.08, "Copy", true, panel_pos)
        guiSetFont(copy_rot, "default-bold-small")
        guiSetProperty(copy_rot, "NormalTextColour", "FFAAAAAA")    
    end
)

function abrir_panelpos()
	showCursor( not isCursorShowing() )
	guiSetVisible (panel_pos, not guiGetVisible ( panel_pos ) )
end
bindKey("F2", "down", abrir_panelpos)

function clickxs()
	if (source == sacar_pos) then
		local x,y,z = getElementPosition( (getPedOccupiedVehicle(localPlayer) or localPlayer) )
		guiSetText(edit_pos, "".. x..", ".. y..", ".. z.."")
		outputChatBox("Interior: "..getElementInterior(localPlayer).."")
		outputChatBox("Dimension: "..getElementDimension(localPlayer).."")
		if getPedOccupiedVehicle(localPlayer) then
			outputChatBox("Vehiculo ID: "..getElementModel(getPedOccupiedVehicle(localPlayer)).."")
		end
	elseif (source == sacar_rotation) then
		local rx,ry,rz = getElementRotation( localPlayer )
		guiSetText(edit_rot, "".. rx..", ".. ry..", ".. rz.."")
	elseif (source == copy_pos) then
	local text = guiGetText(edit_pos)
    setClipboard(text)
	elseif (source == copy_rot) then
	local text2 = guiGetText(edit_rot)
    setClipboard(text2)
    end
end
addEventHandler("onClientGUIClick", root, clickxs)

function poscamera ()
    if getElementData(localPlayer, "Lv") >= 1 then
        local x, y, z, x2, y2, z2 = getCameraMatrix()
        outputChatBox("".. x..", ".. y..", ".. z..", ".. x2..", ".. y2..", ".. z2.."", 255, 0, 0, true)
    end
end
addCommandHandler("c", poscamera)

function pos()
    x, y, z, x2, y2, z2 = getCameraMatrix()
    outputChatBox("".. x..", ".. y..", ".. z..", ".. x2..", ".. y2..", ".. z.."")
end
addCommandHandler("pos", pos)

addCommandHandler('obj',
	function()
		local w, h = guiGetScreenSize ()
		local tx, ty, tz = getWorldFromScreenPosition ( w/2, h/2, 50 )
		local px, py, pz = getCameraMatrix()
		local _, tX, tY, tZ, _,
		_,_,_,_,_,_,buildingId, bx, by, bz, brx, bry, brz, buildingLOD = processLineOfSight(px, py, pz, tx, ty, tz, true, true, true, true, true, true, false, true, localPlayer, true)
		outputChatBox('Objeto ID: '..tostring(buildingId)..' Objeto LOD: '..tostring(buildingLOD))
		outputChatBox('Posion: '..bx..', '..by..', '..bz..', '..brx..', '..bry..', '..brz)
		outputChatBox('Target: '..tX..', '..tY..', '..tZ)
	end
)
