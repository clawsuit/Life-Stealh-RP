

GUIEmpezar = {

    gridlist = {},

    window = {},

    button = {},

    memo = {}

}



local infoTable = {

["Empezar"] = {"Empezar"},

["Hud"] ={"El hud no será completamente mostrado por ahora hasta la nueva versión del servidor.\nPor si no saben al presionar la tecla 'm' podrás ver tu dinero en mano y dinero en banco.\nAl tener una arma en mano solamente te mostrará la munición del arma y los disparos minimos."},

["Vehiculos"] = {"/localizarveh - Localizas tus vehículos.\n\n/vehiculos - todos tus vehículos comprados.\n\n/maletero - abres el maletero.\n\n/candado - Le pones un candado a tu bici.\n\n/vermaletero - ves las cosas guardadas en tu maletero.\n\n/metermaletero -item- -Metes items a tu maletero.\n\n/sacarmaletero -item- - Sacrás lo guardado en tu maletero.\n\n/estacionar - Estacionas tu vehículo.\n\n/estadoveh - Veras el estado de tu vehículo.\n\n/cambiarasiento - Cambias el asiento de piloto a copiloto, solamente debe ser usado roleado o serás sancionado si abusas de ello.\n\n/venderveh - vendes tu vehículo a un jugador.\n/comprarveh - compras el vehículo que te vendieron.\n\n/llenarbidon - Solamente si tienes un bidón vacío comprado puedes obtener bidones de gasolina.\n\n/llenarvehiculo - Llenas de gasolina en tu vehículo, visita las gasolineras.\n\n/cancelar - cancelas la compra de gasolina.\n\n/sirenas - prendes las sirenas de tu vehículo.\n\n/luces - prendes las luces de tu vehículo.\n\nLa letra 'L' - podrás abrir y cerrar el vehículo.\n\n/motor - enciendes tu vehículo."},

["Facciones"] = {"/limpiarfaccion -faccion- - solamente los encargados de facciones\n\n/dejarfaccion - dejas tu facción.\n\n/contratar -jugador- -contratas a un jugador a tu facción.\n/aceptarcontrato - aceptas el contrato.\n/cancelarcontrato - cancelas el contrato.\n\n/mimebros -faccion- -Podrás ver los miembros de tal facción.\n\n/quitarcables - Le quitas los cables a una persona tazeado.\n\n/taser - Cambias tu desert eagle por un taser.\n\n/asignardivision -id- -division- - le asignas la división a un jugador.\n\n/quitardivision - id- -división- - le quitas la división.\n\n/meterdivision id - Meterás a un jugador a tu división.\n\n/sacardivision -id- -Sacarás al jugador de tu división.\n\n/rf -mensaje- -Hablar por la radio de tu facción.\n\n/f - Hablaras por el canal OCC de la radio de tu facción.\n\n/ref - Enviarás un refuerzo a tu posición, nuevamente el comando para cancelar.\n\n/d - Chat Departamental.\n\n/meg - Megáfono.\n/esposar -id- - esposarás a un jugador\n/liberar -id- liberas a un jugador arrestado.\n\n/cono - crearas un cono en tu posición donde te encuentras\n/eliminarcono - eliminaras el cono donde fue creado.\n/barra - crearas una barra en tu posición donde te encuentras\n/eliminarbarra - eliminas la barra donde fue creado.\n\n/reanimar - Revivirás a un jugador.\n\n/curar -id- -curaras a un jugador.\n\n/repararveh - Reparas el vehículo del dueño del auto."},

["Comandos de Chats"] = {"Susurrar: /s /susurro \n\nAcciones sencillas: /ame \n\nCanal OCC: /b /occ \n\nGritar: /g \n\nAcciones complejas: /me \n\nInterpretar el etorno: /do"},

["Comandos y atajos"] = {"Comandos y atajos básicos para jugar en Eternal Roleplay:\n/anim /animacion - Animaciónes del servidor\n\n/misdatos - Datos de tu personaje\n\n/dardni -id- - Le mostrará el dni de tu personaje\n\n/dardni /pagar -id- -cantidad- - Envío de dinero a jugadores.\n\n/caminar /walk - cambiar el estilo de caminar\n\n/bug /bugeado - Este comando se utiliza cada 60 segundos, solamente se usa cuando te encuentres bug, no abuses de él o serás sancionado.\n\n/payuda - Enviarás una petición de ayuda a los administrador, solamente cuando en realidad lo necesites no por cosas que puedes preguntar en /dudas.\n\n/cc /limpiarchat - Limpias el chat.\n\n/admins /staffs - solamente puedes ver los administradores disponibles.\n\n/mp /mensaje -id- -mensaje- - un mensaje privdo a tal persona.\n\n/nomp - Desactivas los mensajes privados de otras personas, pero puedes recibirlas.\n\n/idioma -idioma- - Idioma de tu personaje.\n/guardaridioma - Para guardar el idioma de tu personaje\n\n/yo - Descripción de tu personaje.\n/guardaryo - Guardar la Descripción de tu personaje.\n\n/duda - Envias una duda a los administradores.\n\n/darlicencia -id- -licencia- - le mostraras tu licencia al jugador.\n\n/llamar -numero-\n\n/apagarcelular - Apagas el celular.\n\n/encendercelular - Enciendes el celular.\n\n/colgar\n\n/contestar\n\n/ll - Para hablar por llamada.\n\n/agenda - Solo si tienes una agenda comprada.\n\nSistema de banco.\n\n/fondo\n\n/depositar -cantidad-\n\n/retirar -cantidad-\n\n"},

["Lag"] = {"Estos comandos son para aumentar los FPS en caso que tengas una pc muy mala.\n\n/veryo - Desactiva las descripciones de los personajes de otros.\nSistema de lag\n/lag\nEsto hará que el clima cambie, la distancia bajará las hojas de los arboles serán removidas."},

["Importante"] = {"ASDJAKLD"},

}



addEventHandler("onClientResourceStart", resourceRoot,

    function()

        GUIEmpezar.window[1] = guiCreateWindow(0.32, 0.30, 0.35, 0.41, "Como empezar en Life Steal RP", true)

        guiWindowSetSizable(GUIEmpezar.window[1], false)

        guiSetVisible(GUIEmpezar.window[1], false)

        guiSetAlpha(GUIEmpezar.window[1], 0.90)



        GUIEmpezar.gridlist[1] = guiCreateGridList(0.02, 0.08, 0.33, 0.77, true, GUIEmpezar.window[1])

        guiGridListAddColumn(GUIEmpezar.gridlist[1], "Empezar", 0.9)

        for i = 1, 8 do

            guiGridListAddRow(GUIEmpezar.gridlist[1])

        end

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 0, 1, "Empezar", false, false)

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 1, 1, "Facciones", false, false)

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 2, 1, "Comandos de Chats", false, false)

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 3, 1, "Comandos y atajos", false, false)

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 4, 1, "Vehiculos", false, false)

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 5, 1, "Lag", false, false)

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 6, 1, "Importante", false, false)

        guiGridListSetItemText(GUIEmpezar.gridlist[1], 7, 1, "Hud", false, false)

        GUIEmpezar.memo[1] = guiCreateMemo(0.37, 0.08, 0.61, 0.77, "", true, GUIEmpezar.window[1])

        guiMemoSetReadOnly(GUIEmpezar.memo[1], true)

        GUIEmpezar.button[1] = guiCreateButton(168, 275, 142, 26, "Cerrar", false, GUIEmpezar.window[1])

        guiSetFont(GUIEmpezar.button[1], "default-bold-small")

        guiSetProperty(GUIEmpezar.button[1], "NormalTextColour", "FFAAAAAA")    

    end

)



addEventHandler("onClientGUIClick", resourceRoot, function()

    local itemText = guiGridListGetItemText ( GUIEmpezar.gridlist[1], guiGridListGetSelectedItem ( GUIEmpezar.gridlist[1] ), 1 )

    if source == GUIEmpezar.button[1] then

        guiSetVisible(GUIEmpezar.window[1], false)

        showCursor(false)

    elseif source == GUIEmpezar.gridlist[1] then

        if itemText ~="" then

            if infoTable[tostring(itemText)] then

                guiSetText(GUIEmpezar.memo[1], infoTable[tostring(itemText)][1])

            end

        else

            guiSetText(GUIEmpezar.memo[1], "")

        end

    end

end)



addEvent("setVisible", true)

addEventHandler("setVisible", root, function()

    if guiGetVisible(GUIEmpezar.window[1]) == true then

        guiSetVisible(GUIEmpezar.window[1], false)

        showCursor(false)

    else

        showCursor(true)

        guiSetVisible(GUIEmpezar.window[1], true)

    end

end)