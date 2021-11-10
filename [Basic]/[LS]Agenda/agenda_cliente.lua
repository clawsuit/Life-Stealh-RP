
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        panel_agenda = guiCreateWindow(0.23, 0.16, 0.57, 0.64, "Agenda.", true)
        guiWindowSetSizable(panel_agenda, false)
		guiSetVisible(panel_agenda, false)

        memo_agenda = guiCreateMemo(0.02, 0.10, 0.95, 0.77, "Escribe acá...", true, panel_agenda)
        guardar = guiCreateButton(0.39, 0.90, 0.21, 0.07, "Guardar.", true, panel_agenda)
        cerrar = guiCreateLabel(0.83, 0.04, 0.15, 0.04, "Cerrar aqui", true, panel_agenda)
        guiSetFont(cerrar, "default-small")
        guiLabelSetHorizontalAlign(cerrar, "right", true)
        guiLabelSetVerticalAlign(cerrar, "bottom")    
    end
)

addEvent("abrir_window", true)
addEventHandler("abrir_window", root,
	function(tab)
		if guiGetVisible( panel_agenda ) == true then
			guiSetVisible(panel_agenda, false);showCursor(false)
			guiSetInputEnabled(false)
		else
			guiSetVisible(panel_agenda, true);showCursor(true)
			guiSetText( memo_agenda, tab )
			guiSetInputEnabled(true)
		end
	end
)

addEventHandler("onClientGUIClick", resourceRoot,
	function()
		if source == cerrar then
			guiSetVisible(panel_agenda, false)
			showCursor(false)
			guiSetInputEnabled(false)
		elseif source == guardar then
			local text = guiGetText(memo_agenda)
			triggerServerEvent("enviar_element", localPlayer, text)
		end
	end
)
-- sistema afk
local afkKeys = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
 "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "="}

local afkTime = getTickCount()
local minutes = 1
local minutos = 0
local infos = 0

function resetAFkTime()
	afkTime = getTickCount()
	infos = 0
	localPlayer:setData("AFK", false)
end
for k, v in ipairs(afkKeys) do bindKey(v,"both",resetAFkTime) end

setTimer(
function ()
	if getTickCount()-afkTime > minutes*60000 then
	if infos == 3 then else
	if infos >= 1 then
		mensaje = "[Life Steal-Afk]: Sigues AFK! "
	else
		mensaje = "[Life Steal-Afk]: Te has quedado AFK!"
	end
	infos = infos + 1
	createTrayNotification( mensaje.." ("..infos.."/3)", "default" , true )
	end
	triggerServerEvent("afkKicker", localPlayer, localPlayer) end
end,minutes*60000,0)