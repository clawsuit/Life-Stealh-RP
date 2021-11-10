local WindowSkin = false
local SelectedEditWin = nil
local nacionalidadLabel = "Nacionalidad"
local edadLabel = "Edad"
local sexoLabel = "Sexo"
local r_nacionalidad, g_nacionalidad, b_nacionalidad = 50, 0, 0
local r_edad, g_edad, b_edad = 50, 0, 0
local r_sexo, g_sexo, b_sexo = 50, 0, 0
local skins = getValidPedModels ( )
local count = 0 

local SkinsBloqueados = {
--Normales
[217]=true,
[211]=true,
--Medicos
[70]=true,
[274]=true,
[275]=true,
[276]=true,
[277]=true,
[278]=true,
[279]=true,
--Policias
[196]=true,
[71]=true,
[280]=true,
[281]=true,
[282]=true,
[283]=true,
[284]=true,
[285]=true,
[286]=true,
[287]=true,
[288]=true,
--
}


function dxWindowSkin()
	local now = getTickCount()
	if (WindowSkin == true) then
		--informacion skin
		local info_x_anim = interpolateBetween(0,0,0,120*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		local info_height_anim = interpolateBetween(0,0,0,300*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		dxDrawRectangle(120*sx,info_x_anim, 400*sx, info_height_anim, tocolor(50, 90, 90, 100), false)
		dxDrawText( "Rellena los datos de la Nacionalidad, Edad, Sexo, ETC.\nRecuerda que al cancelar la cuenta se eliminara automaticamente\nRespeta las normas del servidor o serás sancionado\nRecuerda poner la edad de mayor de 17 a menor 50\nCualquier tipo de nacionalidad menos anti rol\nSexo: Masculino o Femenino\nSaludos.", 120*sx, info_x_anim, 400*sx + 120*sx, info_height_anim + info_x_anim, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
		-- anterior
		local button_y_animskin = interpolateBetween(0,0,0,630*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		dxDrawRectangle((420*sx) - 2, (button_y_animskin) - 2, (210*sx) + 3.4, (40*sx) + 3.6, tocolor(0, 50, 0, 60), false)
		if isCursorOverRectangle(420*sx, 630*sy, 210*sx, 40*sx) then
			dxDrawRectangle(420*sx, button_y_animskin, 210*sx, 40*sx, tocolor(50, 80, 80, 100), false)
		else
			dxDrawRectangle(420*sx, button_y_animskin, 210*sx, 40*sx, tocolor(50, 90, 90, 100), false)
		end
		dxDrawText( "Anterior", 420*sx, button_y_animskin, 210*sx + 420*sx, 40*sx + button_y_animskin, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
		--siguiente
		local button_y_animskin2 = interpolateBetween(0,0,0,630*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		dxDrawRectangle((720*sx) - 2, (button_y_animskin2) - 2, (210*sx) + 3.4, (40*sx) + 3.6, tocolor(0, 50, 0, 60), false)
		if isCursorOverRectangle(720*sx, 630*sy, 210*sx, 40*sx) then
			dxDrawRectangle(720*sx, button_y_animskin2, 210*sx, 40*sx, tocolor(50, 80, 80, 100), false)
		else
			dxDrawRectangle(720*sx, button_y_animskin2, 210*sx, 40*sx, tocolor(50, 90, 90, 100), false)
		end
		dxDrawText( "Siguiente", 720*sx, button_y_animskin, 210*sx + 720*sx, 40*sx + button_y_animskin, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
		--
		local fondologin_y_anim = interpolateBetween(0,0,0,120*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		local fondologin_height_anim = interpolateBetween(0,0,0,300*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		local fondologin_height2_anim = interpolateBetween(0,0,0,30*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		dxDrawRectangle(800*sx,fondologin_y_anim, 400*sx, fondologin_height_anim, tocolor(30, 30, 30, 100), false)
		dxDrawRectangle(800*sx,fondologin_y_anim, 400*sx, fondologin_height2_anim, tocolor(50, 90, 90, 100), false)
		dxDrawText( "Rellena los datos", 800*sx, fondologin_y_anim, 400*sx + 800*sx, fondologin_height2_anim + fondologin_y_anim, tocolor(255, 255, 255, 150), 1.00, (Nickainley_Normal or "default-bold"), "center", "center")
		-- Nacionalidad
		local button_y_animskin3 = interpolateBetween(0,0,0,180*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		local fondologin_height3_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		dxDrawRectangle((900*sx) - 2, (button_y_animskin3) - 2, (210*sx) + 3.4, (fondologin_height3_anim) + 3.6, tocolor(r_nacionalidad, g_nacionalidad, b_nacionalidad, 60), false)
		dxDrawRectangle(900*sx, button_y_animskin3, 210*sx, fondologin_height3_anim, tocolor(50, 90, 90, 100), false)
		dxDrawText( nacionalidadLabel, 900*sx, button_y_animskin3, 210*sx + 900*sx, fondologin_height3_anim + button_y_animskin3, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
		--Edad
		local button_y_animskin4 = interpolateBetween(0,0,0,240*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		local fondologin_height4_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		dxDrawRectangle((900*sx) - 2, (button_y_animskin4) - 2, (210*sx) + 3.4, (fondologin_height4_anim) + 3.6, tocolor(r_edad, g_edad, b_edad, 60), false)
		dxDrawRectangle(900*sx, button_y_animskin4, 210*sx, fondologin_height4_anim, tocolor(50, 90, 90, 100), false)
		dxDrawText( edadLabel, 900*sx, button_y_animskin4, 210*sx + 900*sx, fondologin_height4_anim + button_y_animskin4, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
		--Hombre
		local button_y_animskin5 = interpolateBetween(0,0,0,300*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		local fondologin_height5_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		dxDrawRectangle((900*sx) - 2, (button_y_animskin5) - 2, (210*sx) + 3.4, (fondologin_height5_anim) + 3.6, tocolor(r_sexo, g_sexo, b_sexo, 60), false)
		dxDrawRectangle(900*sx, button_y_animskin5, 210*sx, fondologin_height5_anim, tocolor(50, 90, 90, 100), false)
		dxDrawText( sexoLabel, 900*sx, button_y_animskin5, 210*sx + 900*sx, fondologin_height5_anim + button_y_animskin5, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
		--Confirmacion
		local button_y_animskin6 = interpolateBetween(0,0,0,360*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		local fondologin_height6_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		dxDrawRectangle((830*sx) - 2, (button_y_animskin6) - 2, (150*sx) + 3.4, (fondologin_height6_anim) + 3.6, tocolor(0, 50, 0, 60), false)
		if isCursorOverRectangle(830*sx, 360*sy, 150*sx, 40*sy) then
			dxDrawRectangle(830*sx, button_y_animskin6, 150*sx, fondologin_height6_anim, tocolor(50, 80, 80, 100), false)
		else
			dxDrawRectangle(830*sx, button_y_animskin6, 150*sx, fondologin_height6_anim, tocolor(50, 90, 90, 100), false)
		end
		dxDrawText( "Crear", 830*sx, button_y_animskin6, 150*sx + 830*sx, fondologin_height6_anim + button_y_animskin6, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
		--Cancelar
		local button_y_animskin7 = interpolateBetween(0,0,0,360*sy,0,0, (now - tickCount) / ((tickCount + 2500) - tickCount), "OutQuad")
		local fondologin_height7_anim = interpolateBetween(0,0,0,40*sy,0,0, (now - tickCount) / ((tickCount + 1000) - tickCount), "OutQuad")
		dxDrawRectangle((1020*sx) - 2, (button_y_animskin7) - 2, (150*sx) + 3.4, (fondologin_height7_anim) + 3.6, tocolor(50, 0, 0, 60), false)
		if isCursorOverRectangle(1020*sx, 360*sy, 150*sx, 40*sy) then
			dxDrawRectangle(1020*sx, button_y_animskin7, 150*sx, fondologin_height7_anim, tocolor(50, 80, 80, 100), false)
		else
			dxDrawRectangle(1020*sx, button_y_animskin7, 150*sx, fondologin_height7_anim, tocolor(50, 90, 90, 100), false)
		end
		dxDrawText( "Cancelar", 1020*sx, button_y_animskin7, 150*sx + 1020*sx, fondologin_height7_anim + button_y_animskin7, tocolor(255, 255, 255, 150), 1.00, "default-bold", "center", "center")
	end
end

addEventHandler ( "onClientClick", getRootElement(), function ( button, state )
	if ( button == "left" ) and ( state == "down" ) then
		if (WindowSkin == true) then
			-- cancelar
			if isCursorOverRectangle(1020*sx, 360*sy, 150*sx, 40*sy) then
				triggerServerEvent("Roleplay:CancelarCuenta", localPlayer, userLabel, passLabel)
			end
			if isCursorOverRectangle(420*sx, 630*sy, 210*sx, 40*sx) then
		        if count ~= 1 then
		            count = count - 1
		            if skins then
		            	if not SkinsBloqueados[skins[count]] then
		                	setElementModel(localPlayer, skins[count])
		                end
		            end
		        end
			end
			if isCursorOverRectangle(720*sx, 630*sy, 210*sx, 40*sx) then
		        if count ~= #skins then
		            count = count + 1
		            if skins then
		            	if not SkinsBloqueados[skins[count]] then
							setElementModel(localPlayer, skins[count])
		               	end
		            end
		        end
			end
			if isCursorOverRectangle(830*sx, 360*sy, 150*sx, 40*sy) then
				if nacionalidadLabel ~="" then
					if tonumber(edadLabel) >= 17 and tonumber(edadLabel) <= 50 then
						if sexoLabel:find("Masculino") or sexoLabel:find("masculino") or sexoLabel:find("femenino") or sexoLabel:find("Femenino") then
							triggerServerEvent("Roleplay:SetDatos", localPlayer, nacionalidadLabel, edadLabel, sexoLabel, userLabel, localPlayer:getModel())
							setWindowSkin(false)
						else
							r_sexo, g_sexo, b_sexo = 50, 0, 0
						end
					else
						r_edad, g_edad, b_edad = 50, 0, 0
					end
				else
					r_nacionalidad, g_nacionalidad, b_nacionalidad = 50, 0, 0
				end
			end
 			if isCursorOverRectangle(900*sx, 180*sy, 210*sx, 40*sy) then -- nacionalidad
				SelectedEditWin = "nacionalidad"
				nacionalidadLabel = ""
			elseif isCursorOverRectangle(900*sx, 240*sy, 210*sx, 40*sy) then -- edad
				SelectedEditWin = "edad"
				edadLabel = ""
			elseif isCursorOverRectangle(900*sx, 300*sy, 210*sx, 40*sy) then -- sexo
				SelectedEditWin = "sexo"
				sexoLabel = ""
			else
				SelectedEditWin = nil;
			end
		end
	end
end)

bindKey("backspace", "down", function()
	if (WindowSkin == true) then
		if ( SelectedEditWin == "nacionalidad" ) then
			if nacionalidadLabel:len() >= 0 then
				nacionalidadLabel = nacionalidadLabel:sub(1, #nacionalidadLabel-1)
			end
		elseif ( SelectedEditWin == "edad" ) then
			if edadLabel:len() >= 0 then
				edadLabel = edadLabel:sub(1, #edadLabel-1)
			end
		elseif ( SelectedEditWin == "sexo" ) then
			if sexoLabel:len() >= 0 then
				sexoLabel = sexoLabel:sub(1, #sexoLabel-1)
			end
		end
	end
end)

bindKey("tab", "down", function()
	if (WindowSkin == true) then
		if (SelectedEditWin == "nacionalidad") then
			SelectedEditWin = "nacionalidad"
		elseif (SelectedEditWin == "edad") then
			SelectedEditWin = "edad"
		elseif (SelectedEditWin == "sexo") then
			SelectedEditWin = "sexo"
		end
	end
end)

addEventHandler("onClientCharacter", root, function(t)
	if (WindowSkin == true) then
		if ( SelectedEditWin == "nacionalidad" ) then
			nacionalidadLabel = nacionalidadLabel..""..t
			if nacionalidadLabel:len() >= 0 then
				r_nacionalidad, g_nacionalidad, b_nacionalidad = 0, 50, 0
			else
				r_nacionalidad, g_nacionalidad, b_nacionalidad = 50, 0, 0
			end
		elseif (SelectedEditWin == "edad") then
			edadLabel = edadLabel..""..t
			if tonumber(edadLabel) >= 17 and tonumber(edadLabel) <= 50 then
				r_edad, g_edad, b_edad = 0, 50, 0
			else
				r_edad, g_edad, b_edad = 50, 0, 0
			end
		elseif (SelectedEditWin == "sexo") then
			sexoLabel = sexoLabel..""..t
			if sexoLabel:find("Masculino") or sexoLabel:find("masculino") or sexoLabel:find("femenino") or sexoLabel:find("Femenino") then
				r_sexo, g_sexo, b_sexo = 0, 50, 0
			else
				r_sexo, g_sexo, b_sexo = 50, 0, 0
			end
		end
	end
end)

addEvent("Roleplay:ErrorSkin", true)
addEventHandler("Roleplay:ErrorSkin", root, function()
	r_nacionalidad, g_nacionalidad, b_nacionalidad = 50, 0, 0
	r_edad, g_edad, b_edad = 50, 0, 0
	r_sexo, g_sexo, b_sexo = 50, 0, 0
end)

function setWindowSkin(var)
	tickCount = getTickCount()
	if var == true then
		addEventHandler("onClientRender", getRootElement(), dxWindowSkin)
		WindowSkin = var
		showChat(false)
		guiSetInputMode(true)
		showCursor(true)
	else
		removeEventHandler("onClientRender", getRootElement(), dxWindowSkin)
		WindowSkin = false
		showChat(true)
		guiSetInputMode(false)
		showCursor(false)
	end
end
addEvent("setWindowSkin", true)
addEventHandler("setWindowSkin", root, setWindowSkin)