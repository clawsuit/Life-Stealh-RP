Data_c = {} -- Creamos una tabla para almacenamiento de datos

function setDato(p,s,v,shared) -- funcion para insertar crear un dato a un elemento
	if (p) and (s) then
		Data_c[p] = Data_c[p] or {} -- creamos una tabla con el indice del elemento, usando el mismo table[index] sino una nueva {}
		Data_c[p][s] = v -- insertamos los valores a la tabla del elemento
		if shared then
			return
		end
		triggerLatentServerEvent("onReadFile",5000,false,resourceRoot,Data_c)
		return true -- retornamos un booleano verdadero
	end
	return false -- retornamos un booleano falso en caso de que nuestra condicion no se ejecute
end

function getDato(p,s)
	if (p) and (s) then
		if Data_c[p] then
			if Data_c[p][s] then
				return Data_c[p][s]
			end
		end
	end
	return false
end

function getDatos(p,s)
	if (p) and (s) then
		if Data_c[p] then
			return Data_c[p]
		end
	end
	return false
end

function removeDato(p,s)
	if (p) and (s) then
		if Data_c[p] then
			if Data_c[p][s] then
				Data_c[p][s] = nil
				triggerLatentServerEvent("onReadFile",5000,false,resourceRoot, Data_c)
			end
		end
	end
end

addEvent('onClientReadFile', true)
addEventHandler('onClientReadFile', resourceRoot, 
	function(t)
		table.clear(Data_c)
		for k,v in pairs(t) do
			Data_c[k] = v
		end
	end
)

addEventHandler('onClientResourceStop', resourceRoot, 
	function(t)
		table.clear(Data_c)
	end
)

function table.clear(t)
	for k,v in pairs(t) do
		if (type(k) == 'number') then
			table.remove(t,k)
		else
			t[k] = nil
		end
	end
	return true
end
