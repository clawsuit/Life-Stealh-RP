local pickupDNI = Pickup(359.03103637695, 168.09060668945, 1008.3828125, 3, 1581, 0)
pickupDNI:setInterior(3)
pickupDNI:setDimension(0)

local namesMujer = {"Ruth Garcia", "Nicol Gonzalez", "Lucia Fernandes", "Dayana Hernández", "Daniela Rios"}
local namesHombre = {"Carlos Martinez", "Jesus Martinez", "Luis Perez", "Josep Smith"}

function sacarDNI(source)
	if source:getInterior() == 3 and source:getDimension() == 0 then
		if isElementWithinPickup(source, pickupDNI) then
			if source:getMoney() >= 60 then
				local data = query("SELECT * FROM datos_personajes where Cuenta = ?", AccountName(source))
				if not ( type( data ) == "table" and #data == 0 ) or not data then
					local s = data[1]["DNI"]
					local dni = math.random(40000000,50000000)
					if s == "0" then
						source:outputChat("Acabas de ser Fotografiado y tomaron tus huellas para tu documento de identificación.", 25, 80, 150, true)
						update("UPDATE datos_personajes SET DNI = ?  WHERE Cuenta = ?", tonumber(dni), AccountName(source))
						source:takeMoney(60)
						source:outputChat("* Número de D.N.I: #00FF00"..dni, 255, 255, 255, true)
					else
						source:outputChat("Ya tienes tu D.N.I con el Número: #FFFFFF"..s, 150, 50, 50, true)
					end
				end
			else
				source:outputChat("No tienes suficiente dinero para obtener tu DNI", 150, 50, 50, true)
			end
		end
	end
end
addCommandHandler("obtenerdni", sacarDNI)

function isElementWithinPickup(theElement, thePickup)
	if (isElement(theElement) and getElementType(thePickup) == "pickup") then
		local x, y, z = getElementPosition(theElement)
		local x2, y2, z2 = getElementPosition(thePickup)
		if (getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) <= 1) then
			return true
		end
	end
	return false
end

local pickupTarjeta = Pickup(361.82989501953, 173.6374206543, 1008.3828125, 3, 1581, 0)
pickupTarjeta:setInterior(3)
pickupTarjeta:setDimension(0)

function sacarTarjeta(source)
	if source:getInterior() == 3 and source:getDimension() == 0 then
		if isElementWithinPickup(source, pickupTarjeta) then
			if source:getMoney() >= 60 then
				local s = (source:getData("Roleplay:tarjeta_credito") or 0)
				local dni = math.random(40000000,50000000)
				if s == 0 then
					source:outputChat("Acabas de ser Fotografiado y tomaron tus huellas para tu tarjeta de crédito.", 25, 80, 150, true)
					source:setData("Roleplay:tarjeta_credito", (source:getData("Roleplay:tarjeta_credito") or 0) + 1)
					source:takeMoney(60)
				else
					source:outputChat("Ya tienes tu tarjeta de crédito.", 150, 50, 50, true)
				end
			else
				source:outputChat("No tienes suficiente dinero para obtener tu Tarjeta de Credito", 150, 50, 50, true)
			end
		end
	end
end
addCommandHandler("obtenertarjeta", sacarTarjeta)