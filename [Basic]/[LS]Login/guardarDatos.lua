mysql = exports.MySQL

local posicionesJail = {
[1]={197.42677307129, 174.26026916504, 1003.0234375},
[2]={193.36796569824, 174.16159057617, 1003.0234375},
[3]={189.07911682129, 174.79206848145, 1002.9435424805},
[4]={189.89344787598, 161.89308166504, 1002.9435424805},
[5]={194.32360839844, 161.94566345215, 1002.9435424805},
[6]={198.79176330566, 162.10108947754, 1003.0299682617},
}
local valores= {
{70},
{71},
{72},
{73},
{74},
{76},
{77},
{78},
{79},
}
function LoginSaveP( p, c, a )
	if not(mysql:notIsGuest(source)) then 
		--
		local trabajo = c:getData("Roleplay:trabajo")
		if (trabajo) then
			local va = c:getData("Roleplay:trabajo")
			if va == "Licencia" then
				source:setData("Roleplay:trabajo", "")
			else
				source:setData("Roleplay:trabajo", va)
			end
		else
			source:setData("Roleplay:trabajo", "")
		end
		--
		local x, y, z = 1651.2677001953, -2326.1672363281, 13.546875
		local rx, ry, rz = 0, 0, 82.518409729004
		local int = 0
		local dim = 0
		local vida = 100
		local chaleco = 0
		local serial = source:getSerial()
		local skin = 1
		--
		for i, v in ipairs(valores) do
			source:setStat(v[1], 1000)
		end
		--
		local team = ""
		local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")
		if ( type ( save ) == "table" and #save == 0 ) or not save then
			mysql:insert("INSERT INTO save_system VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", toJSON ( { x = x, y = y, z = z} ), toJSON ( { rx = rx, ry = ry, rz = rz} ), math.floor(vida), math.floor(chaleco), int, dim, skin, team, '50000', '', serial, mysql:AccountName(source))

			source:spawn( x, y, z, rz, skin, int, dim)
			source:setHealth(vida)
			source:setArmor(chaleco)
			source:giveMoney(3000)
			--
			source:fadeCamera(true, 0.5)
			source:setCameraTarget(source)
			source:setTeam(nil)
			source:setData("EnEdicion", true)
			showChat(source, false)
			setTimer(triggerClientEvent, 800, 1, source, "setWindowSkin", source, true)
			setTimer(setCameraMatrix, 500, 1, source, 1647.4088134766, -2325.6745605469, 13.378896713257, 1746.4216308594, -2338.6774902344, 13.378896713257)
		else
			local pos = fromJSON(save[1]["Posiciones"])
			local rot = fromJSON(save[1]["Rotaciones"])
			local vida2 = save[1]["Vida"]
			local chaleco2 = save[1]["Chaleco"]
			local skin2 = save[1]["Skin"]
			local int2 = save[1]["Interior"]
			local money = save[1]["Money"]
			local dim2 = save[1]["Dimension"]
			local team2 = save[1]["Team"]
			source:setRotation(rot["rx"], rot["ry"], rot["rz"])
			if exports["[LS]Administracion"]:isPlayerExists(source) then
				exports["[LS]Administracion"]:setPlayerJail(source)
				source:setPosition(pos["x"], pos["y"], pos["z"])
				source:spawn( pos["x"], pos["y"], pos["z"], rot["rz"], skin2, int2, dim2)
			elseif exports["[LS]Facciones"]:isPlayerExistsArresto(source) then
				exports["[LS]Facciones"]:setPlayerJailPolice(source)
				local random = math.random(1,6)
				local x2, y2, z2 = posicionesJail[tonumber(random)][1], posicionesJail[tonumber(random)][2], posicionesJail[tonumber(random)][3]
				source:setPosition(x2, y2, z2)
				source:spawn( x2, y2, z2, rot["rz"], skin2, int2, dim2)
			else
				source:setPosition(pos["x"], pos["y"], pos["z"])
				source:spawn( pos["x"], pos["y"], pos["z"], rot["rz"], skin2, int2, dim2)
			end
			source:setHealth(vida2)
			source:giveMoney(tonumber(money))
			source:setArmor(chaleco2)
			source:setTeam(nil)
			--
			source:fadeCamera(true, 0.5)
			source:setCameraTarget(source)
		end
	end
end
addEventHandler("onPlayerLogin", getRootElement(), LoginSaveP)

function QuitSaveP( q, r, e )
	if not(mysql:notIsGuest(source)) then 
		local acc = source:getAccount()
		if acc then
			local va = source:getData("Roleplay:trabajo")
			acc:setData("Roleplay:trabajo", va)
		end
		local cuenta = mysql:AccountName(source)
		if cuenta then
			local x, y, z = getElementPosition(source)
			local rx, ry, rz = getElementRotation(source)
			local int = source:getInterior()
			local dim = source:getDimension()
			local vida = source:getHealth()
			local chaleco = source:getArmor()
			local serial = source:getSerial()
			local skin = source:getModel()
			local money = source:getMoney()
			local team = ""		
			local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")
			if ( type ( save ) == "table" and #save == 0 ) or not save then
				mysql:insert("INSERT INTO save_system VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", toJSON ( { x = x, y = y, z = z} ), toJSON ( { rx = rx, rx = rx, rx = rx} ), math.floor(vida), math.floor(chaleco), int, dim, skin, team, '5000', '', serial, mysql:AccountName(source))
			else
				--
				if not source:isDead() then
					local weapons = ""
					for index=0,12 do
						local weapon = source:getWeapon(index)
						local ammo = source:getTotalAmmo(index)
						weapons = weapons..tostring(index).."="..tostring(weapon)..","..tostring(ammo)..";"
					end
					mysql:update("UPDATE save_system SET Weapons = ?  WHERE Cuenta = ?", weapons, mysql:AccountName(source))
				else
					mysql:update("UPDATE save_system SET Vida = ?  WHERE Cuenta = ?", 10, mysql:AccountName(source))
				end
				-- money
				mysql:update("UPDATE save_system SET Money = ?  WHERE Cuenta = ?", money, mysql:AccountName(source))
				-- Posiciones
				mysql:update("UPDATE save_system SET Posiciones = ?  WHERE Cuenta = ?", toJSON ( { x = x, y = y, z = z} ), mysql:AccountName(source))
				-- Rotaciones
				mysql:update("UPDATE save_system SET Rotaciones = ?  WHERE Cuenta = ?", toJSON ( { rx = rx, ry = ry, rz = rz} ), mysql:AccountName(source))
				-- Vida y Chaleco
				mysql:update("UPDATE save_system SET Vida = ?  WHERE Cuenta = ?", math.floor(vida), mysql:AccountName(source))
				mysql:update("UPDATE save_system SET Chaleco = ?  WHERE Cuenta = ?", math.floor(chaleco), mysql:AccountName(source))
				-- interior y dimension
				mysql:update("UPDATE save_system SET Interior = ?  WHERE Cuenta = ?", int, mysql:AccountName(source))
				mysql:update("UPDATE save_system SET Dimension = ?  WHERE Cuenta = ?", dim, mysql:AccountName(source))
				-- Skin y Team
				mysql:update("UPDATE save_system SET Skin = ?  WHERE Cuenta = ?", skin, mysql:AccountName(source))
				mysql:update("UPDATE save_system SET Team = ?  WHERE Cuenta = ?", team, mysql:AccountName(source))
				-- Serial
				mysql:update("UPDATE save_system SET Serial = ?  WHERE Cuenta = ?", serial, mysql:AccountName(source))
			end
		end
	end
end
addEvent ("onPlayerStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), QuitSaveP)
addEventHandler ("onPlayerStopResource", getRootElement(), QuitSaveP)

function StopP ()
	for k, v in ipairs (Element.getAllByType("player")) do
		if not (mysql:notIsGuest(v)) then
   			triggerEvent ("onPlayerStopResource", v)
		end
	end
end
addEventHandler ("onResourceStop", resourceRoot, StopP)

-- Weapons Save
function WastedP( totalAmmo, killer, killerWeapon, bodypart, stealth )
	if not(mysql:notIsGuest(source)) then 
		--
		local x, y, z = getElementPosition(source)
		local int = getElementInterior( source )
		local dim = getElementDimension( source )
		local nick = source:getName()
		for i, v in ipairs(getPedWeapons(source)) do
			if v[1] >= 22 then
				local id = math.random(1,2)
				if id == 1 then
					exports["[LS]Weapons_Ground"]:createWeaponGround(v[1], v[2], x - math.random(0, 2.3), y - math.random(0,2.1), z, int, dim, nick)
				elseif id == 2 then
					exports["[LS]Weapons_Ground"]:createWeaponGround(v[1], v[2], x - math.random(0, 2.3), y - math.random(0,2.1), z, int, dim, nick)
				end
			end
		end
		--
		mysql:update("UPDATE save_system SET Weapons = ?  WHERE Cuenta = ?", '', mysql:AccountName(source))
	end
end
addEventHandler("onPlayerWasted", getRootElement(), WastedP)

-- Give Weapons
function SpawnWeaponsP( )
	if not(mysql:notIsGuest(source)) then 
		local cuenta = mysql:AccountName(source)
		local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")
		if not ( type ( save ) == "table" and #save == 0 ) or not save then
			local weapons = save[1]["Weapons"]
			if weapons and type(weapons) == "string" and string.len(weapons) > 0 then
				for index=0,12 do
					local coded_string = string.match(weapons, tostring(index).."=%d+,%d+")
					if coded_string then
						local weapon_start , weapon_end = string.find(coded_string, tostring(index).."=")
						local ammo_start, ammo_end = string.find(coded_string, tostring(index).."=%d+,")
						local decoded_weapon = string.match(coded_string, "%d+", weapon_end)
						local decoded_ammo = string.match(coded_string, "%d+", ammo_end)
						local wep = tonumber(decoded_weapon)
						local ammu = tonumber(decoded_ammo)
						if wep == 1 or wep == 2 or wep == 3 or wep == 4 or wep == 5 or wep == 6 or wep == 7 or wep == 8 or wep == 9 or wep == 10 or wep == 11 or wep == 12 or wep == 13 or wep == 14 or wep == 15 or wep == 40 or wep == 44 or wep == 45 or wep == 46 then
							giveWeapon (source, wep)
						else
							if ammu > 1 then
								giveWeapon(source, wep, ammu)
							end
						end
					else
						print("ERROR: Imposible recobrar arma en Slot: ".. tostring(index).."")
					end
				end
			end
		end
	end
end
addEventHandler("onPlayerSpawn", getRootElement(), SpawnWeaponsP)