local Weapons = {}

Weapons.ID = {

	[1] = 331,

	[2] = 333,

	[3] = 334,

	[4] = 335,

	[5] = 336,

	[6] = 337,

	[7] = 338,

	[8] = 339,

	[9] = 341,

	[22] = 346,

	[23] = 347,

	[24] = 348,

	[25] = 349,

	[26] = 350,

	[27] = 351,

	[28] = 352,

	[29] = 353,

	[32] = 372,

	[30] = 355,

	[31] = 356,

	[33] = 357,

	[34] = 358,

	[35] = 359,

	[36] = 360,

	[37] = 361,

	[38] = 362,

	[16] = 342,

	[17] = 343,

	[18] = 344,

	[39] = 363,

	--[] = ,

	--[] = ,

	--[] = ,

}

local antiSpamW  = {} 



addEvent('onGiveWeapon', true)



function createWeaponGround(wep_id, ammo, x, y, z, int, dim, huellas)

	if wep_id ~= 0 then

		if wep_id >= 22 then

			local ID = Weapons.ID[wep_id]

			z = z - 1

			local weapon = Object(ID, x, y, z)

			local col = ColShape.Sphere(x , y, z +.5,1)

			setElementInterior(weapon, int)

			setElementDimension(weapon, dim)

			weapon:setRotation(86,270,180)

			--

			col:setData('weapon_data',{weapon,wep_id, ammo,col, corona, huellas})

		end

	end

end



addCommandHandler("dejar",

	function(player,cmd, muni)

		local tick = getTickCount()

		if (antiSpamW[player] and antiSpamW[player][1] and tick - antiSpamW[player][1] < 2000) then

			return

		end
		local muni = tonumber(muni)
		local wep_id = player:getWeapon()

		if wep_id ~= 0 then

			if wep_id >= 22 then

				Weapons[player] = Weapons[player] or {}

				local ID = Weapons.ID[wep_id]

				local ammo = player:getTotalAmmo()

				local pos = player.position

				pos.z = pos.z - 1

				if muni and muni <= ammo then

					local weapon = Object(ID, pos)

					local col = ColShape.Sphere(pos.x,pos.y,pos.z +.5,1)

					--local corona = Marker(pos.x,pos.y,pos.z +.3,"corona",1,255,255,0,50)

					setElementInterior(weapon,getElementInterior( player ))
					--setElementInterior(corona,getElementInterior( player ))
					setElementDimension(weapon,getElementDimension( player ))
					--setElementDimension(corona,getElementDimension( player ))

					weapon:setRotation(86,270,180)
					local nick = getPlayerName(player):gsub('_',' ')
					col:setData('weapon_data',{weapon,wep_id, ammo,col, corona, nick})
					--corona:attach(weapon)

					takeWeapon(player, wep_id, muni)

				else
					player:outputChat('* No tienes esa cantidad de balas.',220,220,0)
				end

			end

		end

		if (not antiSpamW[player]) then

			antiSpamW[player] = {}

		end

		antiSpamW[player][1] = getTickCount()

	end

)



addCommandHandler("huellas", function(p)

	if not notIsGuest( p ) then

		if getPlayerDivision(p) == "S.W.A.T." or getPlayerDivision(p) == "DIC" then

			local pos = Vector3(p:getPosition())

			local x, y, z = pos.x, pos.y, pos.z

			for i, v in ipairs(Element.getAllByType("colshape")) do

				if v:getData("weapon_data") then

					if isElementInRange(v, x, y, z, 2) then

						p:outputChat("* Esta arma tiene las huellas de "..v:getData("weapon_data")[6].."", 150, 50, 50, true)

					end

				end

			end

		end

	end

end)



function isElementInRange(ele, x, y, z, range)

   if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then

      return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range -- returns true if it the range of the element to the main point is smaller than (or as big as) the maximum range.

   end

   return false

end



addEventHandler('onGiveWeapon', root,

	function(t)

		client:setAnimation("BOMBER", "BOM_Plant", -1,true, false, false)

		--

		setTimer(function(client)

			setPedAnimation(client)

		end, 500, 1, client)

		giveWeapon(client, t[2], t[3], true )

		if isElement(t[4]) then

			t[4]:destroy()

		end

		if isElement(t[5]) then

			t[5]:destroy()

		end

		if isElement(t[1]) then

			t[1]:destroy()

		end

	end

)

