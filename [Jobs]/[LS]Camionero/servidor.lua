loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
import('*'):init('[LS]Notificaciones')
import('*'):init('[LS]NewData')

addEventHandler("onResourceStart", resourceRoot, function()

	for i, v in ipairs(Camionero.LugaresDeTrabajo) do

		--

		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

		--

		Pickup(v[1], v[2], v[3], 3, 1210, 0)

		Camionero.picksCreados[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)

		Camionero.picksCreados[i]:setInterior(v.int)

		Camionero.picksCreados[i]:setDimension(v.dim)

		setDato(Camionero.picksCreados[i],"MarkerJob", "Camionero", true)

	end

end)

--

addCommandHandler("trabajar", function(player, cmd)

	if not notIsGuest(player) then

		if not player:isInVehicle() then

			if player:getData("Roleplay:trabajo") == "" then

				for i, marker in ipairs(Camionero.picksCreados) do

					if player:isWithinMarker(marker) then

						local job = getDato(marker,"MarkerJob")

						if job == "Camionero" then

							if player:getData("Roleplay:trabajo") == "Camionero" then

								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)

							else

								player:setData("Roleplay:trabajo", "Camionero")

								--

								--player:triggerEvent("IniciarCamionero", player)

								--

								player:outputChat("¡Bienvenido al trabajo de #ffff00Camionero#ffffff!", 255, 255, 255, true)

							end

						end

					end

				end

			end

		end

	end

end)

addCommandHandler("renunciar", function(player, cmd)

	if not notIsGuest(player) then

		if not player:isInVehicle() then

			if player:getData("Roleplay:trabajo") ~="" then

				for i, v in ipairs(Camionero.picksCreados) do

					if player:isWithinMarker(v) then

						local job = getDato(v,"MarkerJob")

						if job == "Camionero" then

							if player:getData("Roleplay:trabajo") == "Camionero" then

								player:setData("Roleplay:trabajo", "")

								--player:triggerEvent("failedMission", player)

							else

								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)

								player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)

							end

						end

					end

				end

			end

		end

	end

end)

addCommandHandler("infocamionero", function(player, cmd)

	if not notIsGuest(player) then

		if not player:isInVehicle() then

			for i, v in ipairs(Camionero.picksCreados) do

				if player:isWithinMarker(v) then

					local job = getDato(v,"MarkerJob")

					if job == "Camionero" and job == player:getData("Roleplay:trabajo") then

						player:outputChat("¡Bienvenidos al trabajo de #5B360FCamionero#ffffff!", 255, 255, 255, true)

						player:outputChat("---------", 100, 100, 100, true)

						player:outputChat("Aquí el trabajo consiste en que debes subir a un camion, y enseguida se te avisara para buscar una carga y entregarla ...", 255, 255, 255, true)

						player:outputChat("Las cargas estan marcadas con un blip marron en tu mapa, y las entregas con un blip de camion", 255, 255, 255, true)

						player:outputChat("Luego de entregar con exito la carga, espera unos segundos mientras se te asigna una nueva entrega!", 255, 255, 255, true)

						player:outputChat("Recuerda llevar tu carga en buen estado.", 150, 150, 50, true)

						player:outputChat("---------", 100, 100, 100, true)

					--	player:outputChat("Si deseas limpiar el chat usa el comando #FF0033/cc", 150, 50, 50, true)
						setTextNoti(player,"Si deseas limpiar el chat usa el comando #FF0033/cc")

					end

				end

			end

		end

	end

end)


newEvent('onCamionero', root,
	function(t)

		if t[1] == 'crear' then

			local id = table.random(Camionero.trailers, 'v')
			local trailer = Vehicle(id, t[3], t[4], t[5]+2)
			trailer:setDamageProof( true )
			setDato(t[2],'Trailer',trailer)

		elseif t[1] == 'clear' then

			local trailer = getDato(t[2],'Trailer')
			if isElement( trailer ) then

				trailer:destroy()
				removeDato(t[2], 'Trailer')

			end

			if tonumber(t[3]) then

				source:giveMoney(t[3])

			end

		elseif t[1] == 'proof' then

			t[2]:setDamageProof( false )

		end

	end
)

