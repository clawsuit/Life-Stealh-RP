local nametag = {}

local nametags = {}



local g_screenX,g_screenY = guiGetScreenSize()

local bHideNametags = false

 

local NAMETAG_SCALE = 1 --Overall adjustment of the nametag, use this to resize but constrain proportions

local NAMETAG_ALPHA_DISTANCE = 50 --Distance to start fading out

local NAMETAG_DISTANCE = 15 --Distance until we're gone

local NAMETAG_ALPHA = 255 --The overall alpha level of the nametag

--The following arent actual pixel measurements, they're just proportional constraints

local NAMETAG_TEXT_BAR_SPACE = 2

local NAMETAG_WIDTH = 122/5

local NAMETAG_HEIGHT = 20/5

local NAMETAG_TEXTSIZE = 0.3

local NAMETAG_OUTLINE_THICKNESS = 1.2

 

 

--

local NAMETAG_ALPHA_DIFF = NAMETAG_DISTANCE - NAMETAG_ALPHA_DISTANCE

NAMETAG_SCALE = 1/NAMETAG_SCALE * 800 / g_screenY

 

-- Ensure the name tag doesn't get too big

local maxScaleCurve = { {0, 0}, {3, 3}, {13, 5} }

-- Ensure the text doesn't get too small/unreadable

local textScaleCurve = { {0, 0.8}, {0.8, 1.2}, {99, 99} }

-- Make the text a bit brighter and fade more gradually

local textAlphaCurve = { {0, 0}, {25, 100}, {120, 190}, {255, 190} }



function nametag.create(p)

	nametags[p] = true

end



function nametag.destroy(p)

	nametags[p] = nil

end



setDevelopmentMode(true)



addEventHandler("onClientRender", getRootElement(), function()

	for _, player in ipairs(Element.getAllByType("player")) do

		if isElement(player) then

			if player ~= localPlayer then

				player:setNametagShowing(false)

				if not nametags[player] then

					nametag.create(player)

				end

			end

		end

	end

	--

	local x, y, z = getCameraMatrix()

	for player in pairs(nametags) do

		while true do

			if not isElement(player) then break end

			local pos = Vector3(player:getPosition())

			local px, py, pz = pos.x, pos.y, pos.z

			local px2, py2, pz2 = pos.x, pos.y, pos.z

			local cx, cy, cz = getCameraMatrix(player)

			local puede = isLineOfSightClear(x, y, z, cx, cy, cz)

			if (not puede) then

				break

			end

			if processLineOfSight(x, y, z, px, py, pz, true, false, false, true, false, true) then break end

			local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )

			if pdistance <= 15 then

				local px, py, pz = getPedBonePosition( player, 3 )

				if not px and not py and not pz then

					local pos = Vector3(player:getPosition())

					local px, py, pz = pos.x, pos.y, pos.z

					sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95 )

				end

				local sx, sy = getScreenFromWorldPosition(px, py, pz)

				if not sx and not sy then

					sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95 )

				end

				if not sx or not sy then break end

				local sx, sy = sx, sy-60

				--

				local px2, py2, pz2 = getPedBonePosition(player, 2)

				if not px2 and not py2 and not pz2 then

					local px2,py2,pz2 = getElementPosition ( player )

					sx2,sy2 = getScreenFromWorldPosition ( px2, py2, pz2+0.95 )

				end

				local sx2, sy2 = getScreenFromWorldPosition(px2, py2, pz2)

				if not sx2 and not sy2 then

					sx2,sy2 = getScreenFromWorldPosition ( px2, py2, pz2+0.95 )

				end

                if not sx2 or not sy2 then break end

				local sx2, sy2 = sx2, sy2 -70

				---

				local scale = 1/((4 / NAMETAG_DISTANCE) * NAMETAG_SCALE)

				scale = math.evalCurve(maxScaleCurve,scale)

				local textscale = math.evalCurve(textScaleCurve,scale)

				local outlineThickness = NAMETAG_OUTLINE_THICKNESS*(scale)

				local width,height =  NAMETAG_WIDTH*scale, NAMETAG_HEIGHT*scale

				local drawX = sx - NAMETAG_WIDTH*scale/2

				drawY = sy2 - 20

				distancaY = sy2 - 20 + 17

				--

				local r, g, b = player:getNametagColor()

				local ping = player:getPing()

				if ping >= 300 then

					textolag = "[LAG]"

				else

					textolag = ""

				end

				local idPlayer = player:getData("ID") or 0
				local rdist = math.round(getDistanceBetweenPoints3D ( x,y,z, px,py,pz ))

				dxDrawBourdeText(1,"".._getPlayerNameR(player:getName()).." #FFFFFF( #FF3300"..idPlayer.."#FFFFFF ) "..textolag.."", sx, sy+35, sx, sy+35, tocolor(r,g,b,255),tocolor(0,0,0,255), 1.5-(rdist/15), "default-bold", "center", "center", false, false, false, true)

				dxDrawRectangle(drawX-3, drawY-3+70, width, height, tocolor(0, 0, 0, 126), false)

				dxDrawRectangle(drawX, drawY+70, (width-6), (height-6), tocolor(60, 0, 60, 255), false)

				local health = player:getHealth()

				local p = -510*(health^2)

				health = math.max(health, 0)/100

				local r, g = math.max(math.min(p + 255*health + 255, 255), 0), math.max(math.min(p + 765*health, 255), 0)

 				if health > 1.0 then

 					health = 1.0

 				end

 				local vida = player:getHealth()

 				if vida then

 					dxDrawRectangle(drawX, drawY+70, ((width - 6)*health), height - 6, tocolor(100, 0, 100, 255))

 				end

 				--

 				local chaleco = player:getArmor()

				if (chaleco > 0) then

					dxDrawRectangle(drawX-3, distancaY-3+70, width, height, tocolor(0, 0, 0, 126), false)

					dxDrawRectangle(drawX, distancaY+70, width-6, height-6, tocolor(121, 121, 121, 126), false)

				end

				local armor = player:getArmor()

				armor = math.max(armor, 0)/100

				if armor > 1.0 then

					armor = 1.0

				end

				if chaleco > 0 then

					dxDrawRectangle(drawX, drawY+87, (width - 6)*armor, height-6, tocolor( 255,255,255,255))

				end

 			end

			break

		end

	end

end)



--

function removeColorCoding ( name )

	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name

end



addEventHandler("onClientResourceStart", resourceRoot, function()

	for _, player in ipairs(Element.getAllByType("player")) do

		if player ~= localPlayer then

			nametag.create(player)

		end

	end

end)



addEventHandler("onClientResourceStop", resourceRoot, function()

	for _, player in ipairs(Element.getAllByType("player")) do

		nametag.destroy(player)

		player:setNametagShowing(true)

	end

end)



addEventHandler("onClientPlayerJoin", getRootElement(), function()

	if source == localPlayer then return end

	source:setNametagShowing(false)

	nametag.create ( source )

end)



addEventHandler("onClientPlayerQuit", getRootElement(), function()

	nametag.destroy(source)

end)



function _getPlayerNameR( name )

	local playerName = name

	local str = name

	local find = str:find('_')

	if (find ) then

		local name = str:sub(1,find-1)..' '..str:sub(find+1)

		return name

	end

	return playerName or ""

end



function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) - 1, (w) - 1, (h) - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) - 1, (w) + 1, (h) - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end



function math.lerp(from,to,alpha)

    return from + (to-from) * alpha

end

 

-- curve is { {x1, y1}, {x2, y2}, {x3, y3} ... }

function math.evalCurve( curve, input )

    -- First value

    if input<curve[1][1] then

        return curve[1][2]

    end

    -- Interp value

    for idx=2,#curve do

        if input<curve[idx][1] then

            local x1 = curve[idx-1][1]

            local y1 = curve[idx-1][2]

            local x2 = curve[idx][1]

            local y2 = curve[idx][2]

            -- Find pos between input points

            local alpha = (input - x1)/(x2 - x1);

            -- Map to output points

            return math.lerp(y1,y2,alpha)

        end

    end

    -- Last value

    return curve[#curve][2]

end

function dxDrawBourdeText(lines, text, x, y, sx, sy, color, color2, size, font, alignX, alignY,clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	local lines = lines or 2

	for i= -lines, lines, lines do
		for j= -lines, lines, lines do
			dxDrawText( text:gsub('#%x%x%x%x%x%x',''), x + i, y + j, sx + i, sy + j, color2, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		
		end
	end
	dxDrawText( text, x, y, sx, sy, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function math.round(num, idp)
  	local mult = 10^(idp or 0)
  	return math.floor(num * mult + 0.5) / mult
end