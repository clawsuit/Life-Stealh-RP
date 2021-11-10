local notificacion = {}

sx_, sy_ = guiGetScreenSize()
sx, sy = sx_/1360, sy_/768

function callNotification(info, text, log)
	table.insert(notificacion, {info, text, getTickCount(), 255, 100, log})
	outputConsole ( "["..info.."-NOTIFICATION] "..text )
	if not log then
		showChat(false)
	end
end
addEvent("callNotification", true)
addEventHandler("callNotification", root, callNotification)

function renderCinamtic()
	for i, v in ipairs(notificacion) do
		local now = getTickCount()
		local width = interpolateBetween(0,0,0,100*sx+dxGetTextWidth(v[2]),0,0, (now - v[3]) / ((v[3] + 2500) - v[3]), "OutQuad")
		local width1 = interpolateBetween(0,0,0,35*sx,0,0, (now - v[3]) / ((v[3] + 2500) - v[3]), "OutQuad")
		if v[1] == "info" then
			r, g, b = 50, 200, 50
			img = "files/info.png"
		elseif v[1] == "error" then
			r, g, b = 150, 50, 50
			img = "files/error.png"
		elseif v[1] == "warning" then
			r, g, b = 255, 255, 50
			img = "files/warning.png"
		end
		dxDrawRectangle( 10*sx, 0*sy+(i*45), width+ 40*sy, 40*sy, tocolor(r, g, b, v[5]), false )
		dxDrawRectangle( 12*sx, 2*sy+(i*45), width + 36*sx, 36*sy, tocolor(0, 0, 0, v[4]), false )
		dxDrawImage( 16*sx, 6*sy+(i*45), width1, 25*sy, img, 0, 0, 0, tocolor(255, 255, 255, v[5]), false )
		--
		if getTickCount()-v[3] > 1000 then
			dxDrawText( v[2], 50*sx, 0*sy+(i*45), width + 50*sx, 40*sy + 0*sy+(i*45), tocolor(255, 255, 255, v[4]), 0.50, "bankgothic", "center", "center", false, true, false, false, false)
		end
		if getTickCount()-v[3] > 4000 then
			v[4] = v[4] - 1
			if v[5] == 0 then else
				v[5] = v[5] - 1
			end
			if v[4] == 0 then
				table.remove(notificacion, i)
				if not log then
					showChat(true)
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, renderCinamtic)