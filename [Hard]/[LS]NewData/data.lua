Data_s = {} -- Creamos una tabla para almacenamiento de datos

function setDato(p,s,v,shared) -- funcion para insertar crear un dato a un elemento
	if (p) and (s) then
		Data_s[p] = Data_s[p] or {} -- creamos una tabla con el indice del elemento, usando el mismo table[index] sino una nueva {}
		Data_s[p][s] = v -- insertamos los valores a la tabla del elemento
		if shared then
			return
		end
		triggerLatentClientEvent("onClientReadFile",5000,false,resourceRoot,Data_s)
		return true -- retornamos un booleano verdadero
	end
	return false -- retornamos un booleano falso en caso de que nuestra condicion no se ejecute
end

function getDato(p,s)
	if (p) and (s) then
		if Data_s[p] then
			if Data_s[p][s] then
				return Data_s[p][s]
			end
		end
	end
	return false
end

function getDatos(p,s)
	if (p) and (s) then
		if Data_s[p] then
			return Data_s[p]
		end
	end
	return false
end

function removeDato(p,s)
	if (p) and (s) then
		if Data_s[p] then
			if Data_s[p][s] then
				Data_s[p][s] = nil
				triggerLatentClientEvent("onClientReadFile",5000,false,resourceRoot,Data_s)
			end
		end
	end
end
addEvent('onReadFile', true)
addEventHandler('onReadFile', resourceRoot, 
	function(t)
		table.clear(Data_s)
		for k,v in pairs(t) do
			Data_s[k] = v
		end
	end
)

addEventHandler('onResourceStop', resourceRoot, 
	function(t)
		table.clear(Data_s)
	end
)

function table.clear(t) --Funcion para limpiar nuestra tabla
	for k,v in pairs(t) do
		if (type(k) == 'number') then
			table.remove(t,k)
		else
			t[k] = nil
		end
	end
	return true
end
