addEvent('VestuarioPoli', true)
addEventHandler('VestuarioPoli',root,
	function(type, id)
		if type == 'Colocar' then
			source:setModel(tonumber(id))
		elseif type == 'Guardar' then
			setAccountData( source.account, 'mySkin:saved', id..'' )
		elseif type == 'Tomar' then
			source:setModel(tonumber(id))
		end
	end
)

addEventHandler( "onPlayerLogin", getRootElement(), 
	function(_,new)
		if new then
			local IDs = new:getData('mySkin:saved') or false
			if IDs then
				source:triggerEvent('refresh:MySkin',source, tonumber(IDs))
			end
		end
	end
)

addEventHandler( "onResourceStart", getResourceRootElement( ), 
	function()
		setTimer(function()
			for _,player in ipairs(Element.getAllByType('player')) do
				if player.account then
					local IDs = player.account:getData('mySkin:saved') or false
					if IDs then
						player:triggerEvent('refresh:MySkin',player, tonumber(IDs))
					end
				end
			end
		end,2000,1)
	end
)
