screenW, screenH = guiGetScreenSize()

sx, sy = screenW/1360, screenH/768


--Life Steal
-- Ticks

Arista_Trial = dxCreateFont( "img/Arista_Trial.ttf", 11 )

Nickainley_Normal = dxCreateFont( "img/Nickainley_Normal.ttf", 15 )

-- labels

local label_informacion = "Escribe los datos correctamente para el ingreso.\n¡Recuerda el servidor aún esta en beta, podría ver-\nunos pequeños errores..\nNo dudes en decirlo o seras sancionado.\nSolo puedes crearte máximo de 2 cuentas."

userLabel = "Nombre_Apellido"

passLabel = "****"

--variables

local WindowLogin = false

local ShowInfo = false

local SelectedEdit = nil

-- colors

local r_error_login, g_error_login, b_error_login = 50, 50, 50

local r_error_login2, g_error_login2, b_error_login2 = 50, 50, 50



function dxLogin()

	local now = getTickCount()

	if (WindowLogin == true) then

		-- fondo de información

		local fondo_x_anim = interpolateBetween(0,0,0,20*sy,0,0, (now - tick) / ((tick + 2500) - tick), "OutQuad")

		dxDrawRectangle(480*sx, fondo_x_anim, 400*sx, 100*sy, tocolor(50, 90, 90, 100), false)

		dxDrawText( label_informacion, 480*sx, fondo_x_anim, 400*sx + 480*sx, 100*sy + fondo_x_anim, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")

		--

		--fondo de login

		local fondologin_y_anim = interpolateBetween(0,0,0,200*sy,0,0, (now - tick) / ((tick + 2500) - tick), "OutQuad")

		local fondologin_height_anim = interpolateBetween(0,0,0,300*sy,0,0, (now - tick) / ((tick + 1000) - tick), "OutQuad")

		local fondologin_height2_anim = interpolateBetween(0,0,0,30*sy,0,0, (now - tick) / ((tick + 1000) - tick), "OutQuad")

		dxDrawRectangle(480*sx,fondologin_y_anim, 400*sx, fondologin_height_anim, tocolor(30, 30, 30, 100), false)

		-- texto

		dxDrawRectangle(480*sx,fondologin_y_anim, 400*sx, fondologin_height2_anim, tocolor(50, 90, 90, 100), false)

		dxDrawText( "Login", 480*sx, fondologin_y_anim, 400*sx + 480*sx, fondologin_height2_anim + fondologin_y_anim, tocolor(255, 255, 255, 150), 1.00, Nickainley_Normal, "center", "center")

		-- username

		local fondologin_y2_anim = interpolateBetween(0,0,0,300*sy,0,0, (now - tick) / ((tick + 2500) - tick), "OutQuad")

		local fondologin_height3_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tick) / ((tick + 1000) - tick), "OutQuad")

		dxDrawRectangle((580*sx) - 2, (fondologin_y2_anim) - 2, (210*sx) + 3.2, (fondologin_height3_anim) + 3.6, tocolor(r_error_login, g_error_login, b_error_login, 60), false)

		dxDrawRectangle(580*sx,fondologin_y2_anim, 210*sx, fondologin_height3_anim, tocolor(50, 90, 90, 100), false)

		dxDrawText( userLabel, 580*sx, fondologin_y2_anim, 210*sx + 580*sx, fondologin_height3_anim + fondologin_y2_anim, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")

		--password

		local fondologin_y3_anim = interpolateBetween(0,0,0,360*sy,0,0, (now - tick) / ((tick + 2500) - tick), "OutQuad")

		local fondologin_height4_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tick) / ((tick + 1000) - tick), "OutQuad")

		dxDrawRectangle((580*sx) - 2, (fondologin_y3_anim) - 2, (210*sx) + 3.2, (fondologin_height4_anim) + 3.6, tocolor(r_error_login2, g_error_login2, b_error_login2, 60), false)

		dxDrawRectangle(580*sx,fondologin_y3_anim, 210*sx, fondologin_height4_anim, tocolor(50, 90, 90, 100), false)

		dxDrawText( passLabel:gsub('.','*'), 580*sx, fondologin_y3_anim, 210*sx + 580*sx, fondologin_height4_anim + fondologin_y3_anim, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")		-- botones

		-- login

		local fondologin_y4_anim = interpolateBetween(0,0,0,440*sy,0,0, (now - tick) / ((tick + 2500) - tick), "OutQuad")

		local fondologin_height5_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tick) / ((tick + 1000) - tick), "OutQuad")

		dxDrawRectangle((520*sx) - 2, (fondologin_y4_anim) - 2, (150*sx) + 3.2, (fondologin_height5_anim) + 3.6, tocolor(20, 50, 50, 60), false)

		if isCursorOverRectangle(520*sx, 440*sy, 150*sx, 40*sy) then

			dxDrawRectangle(520*sx,fondologin_y4_anim, 150*sx, fondologin_height5_anim, tocolor(50, 80, 80, 100), false)

		else

			dxDrawRectangle(520*sx,fondologin_y4_anim, 150*sx, fondologin_height5_anim, tocolor(50, 90, 90, 100), false)

		end

		dxDrawText( "Login", 520*sx, fondologin_y4_anim, 150*sx + 520*sx, fondologin_height5_anim + fondologin_y4_anim, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")

		-- registrarme

		local fondologin_y4_anim = interpolateBetween(0,0,0,440*sy,0,0, (now - tick) / ((tick + 2500) - tick), "OutQuad")

		local fondologin_height5_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tick) / ((tick + 1000) - tick), "OutQuad")

		dxDrawRectangle((690*sx) - 2, (fondologin_y4_anim) - 2, (150*sx) + 3.2, (fondologin_height5_anim) + 3.6, tocolor(20, 50, 50, 60), false)

		if isCursorOverRectangle(690*sx, 440*sy, 150*sx, 40*sy) then

			dxDrawRectangle(690*sx,fondologin_y4_anim, 150*sx, fondologin_height5_anim, tocolor(50, 80, 80, 100), false)

		else

			dxDrawRectangle(690*sx,fondologin_y4_anim, 150*sx, fondologin_height5_anim, tocolor(50, 90, 90, 100), false)

		end

		dxDrawText( "Registrarme", 690*sx, fondologin_y4_anim, 150*sx + 690*sx, fondologin_height5_anim + fondologin_y4_anim, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")

	end

	if ( ShowInfo == true ) then

		-- texto

		dxDrawText( "Dale click en los iconos para copiar el link!", 1090*sx, 520*sy, 250*sx + 1090*sx, 40*sy + 520*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center")

		-- facebook

		dxDrawRectangle(1090*sx, 580*sy, 250*sx, 40*sy, tocolor(255, 255, 255, 100), false)

		dxDrawImage(1100*sx, 590*sy, 30*sx, 25*sy, "img/facebook.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

		dxDrawText( "Life Steal Roleplay", 1090*sx, 585*sy, 250*sx + 1090*sx, 40*sy + 585*sy, tocolor(0, 0, 0, 100), 1.00, "default-bold", "center", "center")

		-- discord

		dxDrawRectangle(1090*sx, 640*sy, 250*sx, 40*sy, tocolor(255, 255, 255, 100), false)

		dxDrawImage(1100*sx, 650*sy, 30*sx, 25*sy, "img/discord.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

		dxDrawText( "Life Steal Roleplay", 1090*sx, 640*sy, 250*sx + 1090*sx, 40*sy + 640*sy, tocolor(0, 0, 0, 100), 1.00, "default-bold", "center", "center")

		-- youtube

		dxDrawRectangle(1090*sx, 700*sy, 250*sx, 40*sy, tocolor(255, 255, 255, 100), false)

		dxDrawImage(1100*sx, 710*sy, 30*sx, 25*sy, "img/youtube.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

		dxDrawText( "No disponible", 1090*sx, 700*sy, 250*sx + 1090*sx, 40*sy + 700*sy, tocolor(0, 0, 0, 100), 1.00, "default-bold", "center", "center")

	end

end



addEventHandler("onClientResourceStart", resourceRoot, function()

	tick = getTickCount()

	addEventHandler("onClientRender", getRootElement(), dxLogin)

	s = Sound("img/music.mp3", true)

	s:setVolume(0.50)

	WindowLogin = true

	ShowInfo = true

	showChat(false)

	showCursor(true)

	setPlayerHudComponentVisible ( "all", false )

	iniciarTransicion()

	guiSetInputEnabled(true)

	guiSetInputMode("no_binds_when_editing")

	triggerServerEvent( "removeTextP", localPlayer )

end)



addEvent("Roleplay:DestroyLogin", true)

addEventHandler("Roleplay:DestroyLogin", root, function()

	removeEventHandler("onClientRender", getRootElement(), dxLogin)

	WindowLogin = false

	ShowInfo = false

	showChat(true)

	if isElement(s) then

		stopSound(s)

	end

	showCursor(false)

	setPlayerHudComponentVisible ( "all", true )

	setPlayerHudComponentVisible ( "area_name", false )

end)



addEventHandler ( "onClientClick", getRootElement(), function ( button, state )

	if ( button == "left" ) and ( state == "down" ) then

		if (ShowInfo == true) then

			-- facebook

			if isCursorOverRectangle(1100*sx, 590*sy, 30*sx, 25*sy) then

				setClipboard( "Life Steal Roleplay :D" )

			end

			-- discord

			if isCursorOverRectangle(1100*sx, 650*sy, 30*sx, 25*sy) then

				setClipboard( "" )

			end

			-- youtube

			if isCursorOverRectangle(1100*sx, 710*sy, 30*sx, 25*sy) then

				setClipboard( "" )

			end

		end

		if (WindowLogin == true) then

			if isCursorOverRectangle(520*sx, 440*sy, 150*sx, 40*sy) then

				if ( userLabel ~="" or userLabel ~="Nombre_Apellido" ) then

					if ( passLabel ~="" ) then

						if userLabel:match("(%u%l*_%u%l*)") then

							triggerServerEvent( "Roleplay:LoginPlayer", localPlayer, userLabel, passLabel )

							r_error_login2, g_error_login2, b_error_login2 = 0, 50, 0

							r_error_login, g_error_login, b_error_login = 0, 50, 0

						else

							r_error_login, g_error_login, b_error_login = 50, 0, 0

							triggerEvent("callNotification", localPlayer, "error", "Por favor, la cuenta debe llevar un Nombre_Apellido", true)

						end

					else

						r_error_login2, g_error_login2, b_error_login2 = 50, 0, 0

						triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su contraseña.", true)

					end

				else

					r_error_login, g_error_login, b_error_login = 50, 0, 0

					triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su cuenta.", true)

				end

			end

			if isCursorOverRectangle(690*sx, 440*sy, 150*sx, 40*sy) then

				if ( userLabel ~="" or userLabel ~="Nombre_Apellido" ) then

					if ( passLabel ~="" ) then

						if userLabel:match("(%u%l*_%u%l*)") then

							triggerServerEvent( "Roleplay:RegisterPlayer", localPlayer, userLabel, passLabel )

							r_error_login2, g_error_login2, b_error_login2 = 0, 50, 0

							r_error_login, g_error_login, b_error_login = 0, 50, 0

						else

							r_error_login, g_error_login, b_error_login = 50, 0, 0

							triggerEvent("callNotification", localPlayer, "error", "Por favor, la cuenta debe llevar un Nombre_Apellido", true)

						end

					else

						r_error_login2, g_error_login2, b_error_login2 = 50, 0, 0

						triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su contraseña.", true)

					end

				else

					r_error_login, g_error_login, b_error_login = 50, 0, 0

					triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su cuenta.", true)

				end

			end

 			if isCursorOverRectangle(580*sx, 300*sy, 210*sx, 40*sy) then

				SelectedEdit = "username"

				userLabel = ""

			elseif isCursorOverRectangle(580*sx, 360*sy, 210*sx, 40*sy) then

				SelectedEdit = "password"

				passLabel = ""

			else

				SelectedEdit = nil;

			end

		end

	end

end)



addEvent("Roleplay:ErrorLogin", true)

addEventHandler("Roleplay:ErrorLogin", root, function()

	r_error_login2, g_error_login2, b_error_login2 = 50, 0, 0

	r_error_login, g_error_login, b_error_login = 50, 0, 0

end)



bindKey("backspace", "down", function()

	if (WindowLogin == true) then

		if ( SelectedEdit == "username" ) then

			if userLabel:len() >= 0 then

				userLabel = userLabel:sub(1, #userLabel-1)

			end

		elseif ( SelectedEdit == "password" ) then

			if passLabel:len() >= 0 then

				passLabel = passLabel:sub(1, #passLabel-1)

			end

		end

	end

end)



bindKey("tab", "down", function()

	if (WindowLogin == true) then

		if (SelectedEdit == "username") then

			SelectedEdit = "username"

		elseif (SelectedEdit == "password") then

			SelectedEdit = "password"

		end

	end

end)



addEventHandler("onClientCharacter", root, function(t)

	if (WindowLogin == true) then

		if ( SelectedEdit == "username" ) then

			userLabel = userLabel..""..t

			if userLabel:match("(%u%l*_%u%l*)") or userLabel ~="Nombre_Apellido" then

				r_error_login, g_error_login, b_error_login = 0, 50, 0

			else

				r_error_login, g_error_login, b_error_login = 50, 0, 0

			end

		elseif (SelectedEdit == "password") then

			passLabel = passLabel..""..t

			if passLabel:len() >= 8 then

				r_error_login2, g_error_login2, b_error_login2 = 0, 50, 0

			elseif passLabel:len() >= 4 then

				r_error_login2, g_error_login2, b_error_login2 = 50, 50, 0

			else

				r_error_login2, g_error_login2, b_error_login2 = 50, 0, 0

			end

		end

	end

end)



function isCursorOverRectangle( x, y, width, height )

	if ( not isCursorShowing( ) ) then

		return false

	end

    local sx, sy = guiGetScreenSize ( )

    local cx, cy = getCursorPosition ( )

    local cx, cy = ( cx * sx ), ( cy * sy )

    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then

        return true

    else

        return false

    end

end