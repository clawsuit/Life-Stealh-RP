addEventHandler ( "onClientResourceStart", root,

function ( )

	local objects = getElementsByType( 'object' ) 

	for i=1, #objects do

		local v = objects[ i ]

		local model = getElementModel( v )

		--engineSetModelLODDistance ( v, 220 )

		--setFarClipDistance( 4000 )

		setOcclusionsEnabled ( false )

	end

end

)



local FPSLimit, lastTick, framesRendered, FPS = 61, getTickCount(), 0, 0

local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768



local hudPlayer = false

local loadingSprint = false



function addhudPlayer()

	if hudPlayer == false then

		hudPlayer = true

	end

end

addEvent("addhudPlayer", true)

addEventHandler("addhudPlayer", root, addhudPlayer)



function removeHudPlayer()

	if hudPlayer == true then

		hudPlayer = false

	end

end

addEvent("removeHudPlayer", true)

addEventHandler("removeHudPlayer", root, removeHudPlayer)



local meses = {

[1]={"Enero"},

[2]={"Febrero"},

[3]={"Marzo"},

[4]={"Abril"},

[5]={"Mayo"},

[6]={"Junio"},

[7]={"Julio"},

[8]={"Agosto"},

[9]={"Septiembre"},

[10]={"Octubre"},

[11]={"Noviembre"},

[12]={"Diciembre"},

}



local nameWeapon = {

[22]="Pistola 9mm",

[24]="Desert Eagle .44",

[25]="Escopeta Remington",

[33]="Rifle de Caza",

[29]="Subfusil MP5",

[31]="Fusil M4A1",

[30]="AK-47",

}



local components = {"money", "area_name", "radio", "vehicle_name", "clock", "health", "armour", "breath", "weapon", "wanted", "ammo"}



tamanoletras = (sx/sy)*2.45

local screenW, screenH = guiGetScreenSize()

if screenW <= 1366 and screenH <= 768 then

	tamanoletras = (sx/sy)*1.50

end



addEventHandler("onClientPreRender", root, function(time)

	if hudPlayer == true then

		local stamina = localPlayer:getData("Roleplay:stamina") or 100

		local state = getPedMoveState(localPlayer)

		if stamina >= 100 then

			loadingSprint = false

		end

		if ( state == "sprint" ) then

			if ( stamina >= 0 ) then

				stamina = stamina-(0.002*time)

			end

		else

			if ( stamina <= 100 ) then

				if ( state == "stand" ) then -- si el jugador esta quieto aumenta un poco mas rapido

					stamina = stamina+(0.002*time)

					loadingSprint = true

				else

					stamina = stamina+(0.0013*time)

					loadingSprint = true

				end

			end

		end

		if ( state == "jump" ) then

			if ( stamina >= 0 ) then

				stamina = stamina-(0.008*time)

			end

		end

		if ( stamina <= 5 ) then

			toggleControl( "sprint", false )

			toggleControl( "jump", false )

		end

		if ( stamina >= 50 ) then

			toggleControl( "sprint", true )

			toggleControl( "jump", true )

		end

		localPlayer:setData("Roleplay:stamina", stamina)

	end

end)



addEventHandler("onClientRender", getRootElement(), function()

	if not isPlayerMapVisible() then

		local currentTick = getTickCount()

		local elapsedTime = currentTick - lastTick

		

		if elapsedTime >= 1000 then

			FPS = framesRendered

			lastTick = currentTick

			framesRendered = 0

		else

			framesRendered = framesRendered + 1

		end

		

		if FPS > FPSLimit then

			FPS = FPSLimit

		end

		localPlayer:setData("FPS", ""..tonumber(FPS).." FPS")

		dxDrawText("Eternal Roleplay v1.0", 395*sx, 741*sy, 1358*sx, 314*sy, tocolor(255, 255, 255, 120), 1.00, "default", "right", "top", false, false, false, false, false)

		if hudPlayer == true then

			time = getRealTime ()

			day = time.monthday

			mes = time.month 	

			ano = time.year + 1900

			hour = time.hour

			mins = time.minute

			if day <= 9 then

				dia = "0"..day..""

			else

				dia = day

			end

			if hour <= 9 then

				hora = "0"..hour..""

			else

				hora = hour

			end

			if mins <= 9 then

				minutos = "0"..mins..""

			else

				minutos = mins

			end

			dxDrawText("/yo : ["..(localPlayer:getData("yo")[1]).."]", 10*sx, 730*sy, 0*sx, 314*sy, tocolor(195, 234, 255, 200), 1.00, "default", "left", "top", false, false, false, false, false)

			dxDrawText(""..dia.." de ".. meses[(mes+1)][1].." de "..ano.." - "..hora..":"..minutos.." (GMT) - "..localPlayer:getPing().." ms - "..(localPlayer:getData("FPS") or 0).." - "..localPlayer:getName().." [ID: "..(localPlayer:getData("ID") or 0).."]", 10*sx, 750*sy, 0*sx, 314*sy, tocolor(195, 234, 255, 200), 1.00, "default", "left", "top", false, false, false, false, false)

		

			for _, component in ipairs( components ) do

				setPlayerHudComponentVisible( component, false )

			end

			dxSetAspectRatioAdjustmentEnabled( true )

			--

			if getKeyState( "m" ) then

				local money = getPlayerMoney()

				if tonumber(money) >= 0 then

					colorMoneyR, colorMoneyG, colorMoneyB = 33, 108, 42

				else

					colorMoneyR, colorMoneyG, colorMoneyB = 150, 50, 50

				end

				dxDrawRectangle(1140*sx, 40*sy, 200*sx, 40*sy, tocolor(0, 0, 0, 0), false)

				dxDrawBorderedText("$"..money, 1140*sx, 40*sy, 200*sx + 1140*sx, 40*sy + 40*sy, tocolor(colorMoneyR, colorMoneyG, colorMoneyB, 255), 1.05, "pricedown", "right", "center")

				--

				local bankmoney = localPlayer:getData("Roleplay:bank_balance") or 0

				if tonumber(bankmoney) >= 0 then

					colorBancoR, colorBancoG, colorBancoB = 106, 159, 106

				else

					colorMoneyR, colorMoneyG, colorMoneyB = 150, 50, 50

				end

				dxDrawRectangle(1140*sx, 80*sy, 200*sx, 40*sy, tocolor(0, 0, 0, 0), false)

				dxDrawBorderedText("$"..bankmoney, 1140*sx, 80*sy, 200*sx + 1140*sx, 40*sy + 80*sy, tocolor(colorBancoR, colorBancoG, colorBancoB, 255), 1.05, "pricedown", "right", "center")



				if getPedWeapon( localPlayer ) ~= 0 then

					local ammo = getPedAmmoInClip ( localPlayer )

					local totalammo = getPedTotalAmmo( localPlayer )-ammo

					dxDrawRectangle(1140*sx, 120*sy, 200*sx, 40*sy, tocolor(0, 0, 0, 0), false)

					dxDrawBorderedText(""..totalammo.." #737373"..ammo, 1140*sx, 120*sy, 200*sx + 1140*sx, 40*sy + 120*sy, tocolor(200, 200, 200, 255), 1.05, "pricedown", "right", "center")

				end

			else

				if getPedWeapon( localPlayer ) ~= 0 then

					local ammo = getPedAmmoInClip ( localPlayer )

					local totalammo = getPedTotalAmmo( localPlayer )-ammo

					dxDrawRectangle(1140*sx, 80*sy, 200*sx, 40*sy, tocolor(0, 0, 0, 0), false)

					dxDrawBorderedText(""..totalammo.." #737373"..ammo, 1140*sx, 40*sy, 200*sx + 1140*sx, 40*sy + 40*sy, tocolor(200, 200, 200, 255), 1.05, "pricedown", "right", "center")

				end

			end

			--

		end

	end

end)



function getNameWeapon(player)

	return nameWeapon[tonumber(getPedWeapon(player))]

end



function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end



function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y - 2, w - 2, h - 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y - 2, w + 2, h - 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y + 2, w - 2, h + 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y + 2, w + 2, h + 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y, w - 2, h, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y, w + 2, h, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y - 2, w, h - 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y + 2, w, h + 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )

	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )

end