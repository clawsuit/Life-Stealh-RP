loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

function agenda_open( source )
	if not notIsGuest( source ) then
		if source:getData("Roleplay:Agenda") == "Si" then
			local texto = source:getData("Roleplay:AgendaTexto") or ""
			source:triggerEvent("abrir_window", source, texto)
		else
			source:outputChat("* No tienes una agenda.", 150, 0, 0, ture)
		end
	end
end
addCommandHandler("agenda", agenda_open)

addEvent("enviar_element", true)
addEventHandler("enviar_element", root, function( text )
	local account = source:getAccount()
	if account then
		source:setData("Roleplay:AgendaTexto", text)
		account:setData("Roleplay:AgendaTexto", text)
		
		source:outputChat("* Acabas de guardar lo que escribiste en tu agenda..", 0, 150, 0, true)
	end
end)

local accounts = {["Steven_Shelby"] = true, ["Cesar_Valtierra"] =true, ["Claw_Suit"]=true},
addEvent("afkKicker",true)
addEventHandler("afkKicker",root,
function (player)
	if accounts[AccountName(player)] then return end
	player:setData("AFK", true)
end)