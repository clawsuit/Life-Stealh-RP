function misDatos ( source )
	if not notIsGuest( source ) then
		local cuenta = AccountName(source)
		local accounts = query("SELECT * FROM Datos_Personajes where Cuenta = ?", cuenta)
		if not ( type( accounts ) == "table" and #accounts == 0 ) or not accounts then
			local nombre = accounts[1]["Cuenta"]
			local edad = accounts[1]["Edad"]
			local sexo = accounts[1]["Sexo"]
			local dni2 = accounts[1]["DNI"]
			local nacio = accounts[1]["Nacionalidad"]
			if dni2 == "0" then
				dni = "No"
			else
				dni = dni2
			end
			--
			--
			source:outputChat("#969696-------- Datos de: #FF6666"..cuenta.." #969696--------", 150, 150, 150, true)
			source:outputChat("#FFCACAEdad: #EDFFA9"..edad.."", 150, 150, 150, true)
			source:outputChat("#FFCACASexo: #EDFFA9"..sexo.."", 150, 150, 150, true)
			source:outputChat("#FFCACAD.N.I: #EDFFA9"..dni.."", 150, 150, 150, true)
			source:outputChat("#FFCACANacionalidad: #EDFFA9"..nacio.."", 150, 150, 150, true)
			local telefono =  source:getData("Roleplay:Telefono") or "No"
			if telefono == "Si" then--
				source:outputChat("#FFCACANumero de tu Celular: #EDFFA9"..(source:getData("Roleplay:NumeroTelefono") or 0).."", 150, 150, 150, true)
			end
			local agenda = source:getData("Roleplay:Agenda") or "No" -- 
			source:outputChat("#FFCACATelefono: #EDFFA9"..telefono.."", 150, 150, 150, true)
			source:outputChat("#FFCACAAgenda: #EDFFA9"..agenda.."", 150, 150, 150, true)
			--
			source:outputChat("#969696--------#FF6666 Tarjeta #969696--------", 150, 150, 150, true)
			if (source:getData("Roleplay:tarjeta_credito") or 0) == 1 then
				tarjeta = "Si"
			else
				tarjeta = "No"
			end--
			source:outputChat("#FFCACATarjeta de Credito: #EDFFA9"..tarjeta.."", 150, 150, 150, true)
			--Licencias
			source:outputChat("#969696--------#FF6666 Lincencias #969696--------", 150, 150, 150, true)
			if (source:getData("Roleplay:Licencia_Conducir") or 0) == 1 then
				conducir = "Si"
			else
				conducir = "No"
			end
			if (source:getData("Roleplay:Licencia_Navegar") or 0) == 1 then
				navegar = "Si"
			else
				navegar = "No"
			end
			if (source:getData("Roleplay:Licencia_Piloto") or 0) == 1 then
				piloto = "Si"
			else
				piloto = "No"
			end
			if (source:getData("Roleplay:Licencia_Pesca") or 0) == 1 then
				pesca = "Si"
			else
				pesca = "No"
			end
			source:outputChat("#FFCACALicencia de Conducir: #EDFFA9"..conducir, 150, 150, 150, true)
			source:outputChat("#FFCACALicencia de Navegar: #EDFFA9"..navegar, 150, 150, 150, true)
			source:outputChat("#FFCACALicencia de Piloto: #EDFFA9"..piloto, 150, 150, 150, true)
			source:outputChat("#FFCACALicencia de Pesca: #EDFFA9"..pesca, 150, 150, 150, true)
			source:outputChat("#FFCACALicencia de Armas: #EDFFA9No", 150, 150, 150, true)
		end
	end
end
addCommandHandler("misdatos", misDatos)