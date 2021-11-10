--[[function savePlayerMoney( p, t, a )

	if not notIsGuest( source ) then

		local bank_balance = t:getData("Roleplay:bank_balance")

		if ( bank ) then

			source:setData("Roleplay:bank_balance", bank_balance)

		else

			source:setData("Roleplay:bank_balance", 0)

		end

		--

		local tarjeta = t:getData("Roleplay:tarjeta_credito")

		if (tarjeta) then

			local va = t:getData("Roleplay:tarjeta_credito")

			source:setData("Roleplay:tarjeta_credito", va)

		else

			source:setData("Roleplay:tarjeta_credito", 0)

		end

	end

end

addEventHandler("onPlayerLogin", getRootElement(), savePlayerMoney)



function quitMoney( q, r, e )

	if not notIsGuest( source ) then

		local account = source:getAccount()

		if ( account ) then

			local bank_money = source:getMoney()

			account:setData("Roleplay:bank_money", bank_money)

			--

			local bank_balance = source:getData("Roleplay:bank_balance") or 0
			source:setData("Roleplay:bank_balance", bank_balance)

			--

			local va2 = source:getData("Roleplay:tarjeta_credito")

			account:setData("Roleplay:tarjeta_credito", va2)

		end

	end

end

addEvent("onPlayerSaveQuit", true)

addEventHandler("onPlayerQuit", getRootElement(), quitMoney)

addEventHandler("onPlayerSaveQuit", getRootElement(), quitMoney)



--- onResourceStop

function stopMoney( )

	for i, v in ipairs( Element.getAllByType("player") ) do

		if not notIsGuest( v ) then

			triggerEvent("onPlayerSaveQuit", v)

		end

	end

end

addEventHandler("onResourceStop", resourceRoot, stopMoney)



function convertNumber ( number )   

    local formatted = number   

    while true do       

        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')     

        if ( k==0 ) then       

            break   

        end   

    end   

    return formatted 

end ]]