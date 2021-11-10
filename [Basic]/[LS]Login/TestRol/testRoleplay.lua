local PuntosRolepaly = 0
local PuntosTotal = 0
local PasosRoleplay = 1
local RoleplayPreguntas = {
-- Pregunta número 1
{
{Pregunta="¿Qué es el Roleplay?"},
{Repuesta={"* Un tipo de juego deatmatch.", "* Un tipo de juego que simula la vida real lo más posible.", "* Un tipo de juego donde se puede trollear."}}
},
-- Pregunta número 2
{
{Pregunta="¿Qué es DM?"},
{Repuesta={"* Dead Morthy", "* No correr en circulos.", "* Matar lastimar a una persona sin razón."}}
},
-- Pregunta número 3
{
{Pregunta="¿Qué es PG?"},
{Repuesta={"* Cosas que no harías la vida real.", "* Poderoso Gamer", "* No disparar sin razón."}}
},
-- Pregunta número 4
{
{Pregunta="¿Qué es NRE?"},
{Repuesta={"* No Rolear Escote", "* No Rolear Entorno", "* No Robo Etopico"}}
},
-- Pregunta número 5
{
{Pregunta="¿Qué es NRA?"},
{Repuesta={"* No Rolear Arma", "* No Rolear Armario", "* No Robar Auto"}}
},
-- Pregunta número 6
{
{Pregunta="¿Qué es el BA?"},
{Repuesta={"* Bad Admin", "* Bug Abuse", "* Bariable Activa"}}
},
-- Pregunta número 7
{
{Pregunta="Si robas a alguien ¿Qué debes hacer?"},
{Repuesta={"* Rolear entorno", "* Escapar en mi carro.", "*Esperar a los policias y matarlos."}}
},
-- Pregunta número 8
{
{Pregunta="¿Estás dispuesto a llevar un rol impeclable en el servidor?"},
{Repuesta={"Si", "Si", "No"}},
},
-- Pregunta número 9
{
{Pregunta="¿Qué es NRR?"},
{Repuesta={"* No Rolear Rotación", "* No Robar Rabano", "* No Rolear Robo"}},
},
-- Pregunta número 10
{
{Pregunta="¿Estas dispuesto a cumplir estas reglas y asumir sus consecuencias?"},
{Repuesta={"Si", "Si", "No"}},
},
}

local PuntosRepuestaTable = {
-- 1
["* Un tipo de juego que simula la vida real lo más posible."]= 2,
["* Matar lastimar a una persona sin razón."]= 1,
["* No disparar sin razón."] = 1,
["* No Rolear Entorno"] = 1,
["* No Rolear Arma"] = 1,
["* Bug Abuse"] = 1,
["* Rolear entorno "] = 1,
["Si"] = 1,
[" No Rolear Robo"] = 1,
["Si"] = 2,
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelRoleplay = guiCreateWindow(0.32, 0.34, 0.36, 0.32, "Pasos: 1/10", true)
        guiWindowSetSizable(PanelRoleplay, false)
        guiSetVisible(PanelRoleplay, false)

        LabelPregunta = guiCreateLabel(0.02, 0.11, 0.96, 0.18, "Pregunta: ¿?", true, PanelRoleplay)
        guiSetFont(LabelPregunta, "default-bold-small")
        guiLabelSetHorizontalAlign(LabelPregunta, "center", true)
        guiLabelSetVerticalAlign(LabelPregunta, "center")
        ListaRepuestas = guiCreateGridList(0.04, 0.32, 0.94, 0.47, true, PanelRoleplay)
        guiGridListAddColumn(ListaRepuestas, "Repuestas", 0.9)
        botonSiguiente = guiCreateButton(0.41, 0.83, 0.18, 0.13, "Siguiente..", true, PanelRoleplay)
        guiSetProperty(botonSiguiente, "NormalTextColour", "FFAAAAAA")    
    end
)
local PasosRoleplay2 = 0
addEventHandler("onClientGUIClick", resourceRoot, function()
	local repuesta = guiGridListGetItemText ( ListaRepuestas, guiGridListGetSelectedItem ( ListaRepuestas ), 1 )
	if source == botonSiguiente then
		if repuesta ~="" then
			if PuntosRepuestaTable[repuesta] then
				PuntosRolepaly = PuntosRolepaly + PuntosRepuestaTable[repuesta]
			end
			if PasosRoleplay >= 1 and PasosRoleplay <= 9 then
				PasosRoleplay = PasosRoleplay + 1
				PasosRoleplay2 = PasosRoleplay2 + 1
				loadPreguntas()
			elseif PasosRoleplay >= 10 then
				PuntosTotal = PuntosRolepaly
				PasosRoleplay2 = PasosRoleplay2 + 1
			end
			print(PuntosTotal)
			if PasosRoleplay2 >= 10 then
				if PuntosTotal >= 10 then
					outputChatBox("¡Muy bien pasaste el test de rol!", 50, 150, 50)
					guiSetVisible( PanelRoleplay, false )
					showCursor(false)
					triggerServerEvent("PasoElRol", localPlayer)
				else
					triggerServerEvent("kickedPlayer", localPlayer)
					guiSetVisible( PanelRoleplay, false )
					showCursor(false)
				end
			end
		else
			outputChatBox("¡Debes selecciona una repuesta antes de ir a la siguiente!", 150, 50, 50)
		end
	end
end)

addEvent("setVisibleTestRol", true)
addEventHandler("setVisibleTestRol", root, function()
	if guiGetVisible(PanelRoleplay) == true then
		guiSetVisible(PanelRoleplay, false)
		showCursor(false)
	else
		guiSetVisible(PanelRoleplay, true)
		showCursor(true)
		loadPreguntas()
	end
end)

function loadPreguntas()
	guiGridListClear(ListaRepuestas)
	for i, s in ipairs(RoleplayPreguntas) do
		if PasosRoleplay >= i and PasosRoleplay <= i then
			local valPre = s[1]
			guiSetText(PanelRoleplay, "Pasos: "..i.."/10")
			guiSetText(LabelPregunta, "Pregunta: "..valPre.Pregunta)
			local valRep = s[2]
			local r1 = math.randomDiff(1, #valRep.Repuesta)
			local r2 = math.randomDiff(1, #valRep.Repuesta, r1)
			local r3 = math.randomDiff(1, #valRep.Repuesta, r1,r2)
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r1])
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r2])
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r3])
			guiGridListSetSortingEnabled ( ListaRepuestas, false )
			--guiGridListSetItemText(ListaRepuestas, row, 1, tostring(math.randomDiff(1, v)), false, false)
		end
	end
end

function math.randomDiff(a, b, distA, distB)
	local distA = distA or 0
	local distB = distB or 0
	local random = math.random(a,b)
	while random == distA or random == distB do
		random = math.random(a,b)
		if random ~= distA and random ~= distB then
			break;
		end
	end
	return random
end
