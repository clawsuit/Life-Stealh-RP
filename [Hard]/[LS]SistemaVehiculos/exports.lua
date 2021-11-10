addEventHandler("onResourceStart", resourceRoot, function ( )
	dbVehiculos = Connection("sqlite", "Vehiculos.db")
	if dbVehiculos then
		print("Conectado a la base de datos 'Vehiculos.db'")
	else
		print("Error al conectar con la DB")
	end
end);

function databaseQuery( ... )
	if dbVehiculos then
		local s = dbVehiculos:query(...)
		local result = s:poll(-1)
		return result
	else
		return false
	end
end

function databaseUpdate( ... )
	if dbVehiculos then
		return dbVehiculos:exec(...)
	else
		return false
	end
end

function databaseInsert( ... )
	if dbVehiculos then
		return dbVehiculos:exec(...)
	else
		return false
	end
end

function databaseDelete( ... )
	if dbVehiculos then
		return dbVehiculos:exec(...)
	else
		return false
	end
end


addEventHandler("onResourceStart", resourceRoot, function ( ) -- CREATE TABLE IF NOT EXISTS Vehiculos
	databaseQuery("CREATE TABLE IF NOT EXISTS Info_Vehicles (ID INTEGER, Llave INTEGER, Cuenta TEXT, Modelo TEXT, Gasolina INTEGER, X INTEGER, Y INTEGER, Z INTEGER, rotZ INTEGER, Vida INTEGER, Paint INTEGER, Upgrades TEXT, Color TEXT, Placa INTEGER)")
end)