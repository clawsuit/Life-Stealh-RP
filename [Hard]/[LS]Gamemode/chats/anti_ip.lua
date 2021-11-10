local insults = {
"mtasa://",
}

local ip = {
--[[ INIT 4 SLOT ]] 
"%d%d%d%.%d%d%d%.%d%d%d%.%d", 
"%d%d%d%.%d%d%d%.%d%d%.%d", 
"%d%d%d%.%d%d%d%.%d%.%d", 
"%d%d%d%.%d%d%.%d%d%d%.%d", 
"%d%d%d%.%d%d%.%d%d%.%d", 
"%d%d%d%.%d%d%.%d%.%d", 
"%d%d%d%.%d%.%d%d%d%.%d", 
"%d%d%d%.%d%.%d%d%.%d", 
"%d%d%d%.%d%.%d%.%d", 
--[[ INIT 3 SLOT ]] 
"%d%d%.%d%d%d%.%d%d%d%.%d", 
"%d%d%.%d%d%d%.%d%d%.%d", 
"%d%d%.%d%d%d%.%d%.%d", 
"%d%d%.%d%d%.%d%d%d%.%d", 
"%d%d%.%d%d%.%d%d%.%d", 
"%d%d%.%d%d%.%d%.%d", 
"%d%d%.%d%.%d%d%d%.%d", 
"%d%d%.%d%.%d%d%.%d", 
"%d%d%.%d%.%d%.%d", 
--[[ INIT 2 SLOT ]] 
"%d%.%d%d%d%.%d%d%d%.%d", 
"%d%.%d%d%d%.%d%d%.%d", 
"%d%.%d%d%d%.%d%.%d", 
"%d%.%d%d%.%d%d%d%.%d", 
"%d%.%d%d%.%d%d%.%d", 
"%d%.%d%d%.%d%.%d", 
"%d%.%d%.%d%d%d%.%d", 
"%d%.%d%.%d%d%.%d", 
"%d%.%d%.%d%.%d" 
}

local replace_sentence = {
"#ff0000ยก#@!"
}

local max_insult = 3;
local uebereinstimmungsrate = 4;
local handle_type = 1;
-- handle_type 1 = replaces the offense with a gay word
-- handle_type 2 = kicks a user searches for "max_insult" from the server.
-- handle_type 3 = recursively also sets up terms (not being completed)
-- handle_type 4 = undertakes nothing

addEventHandler("onPlayerChat", root, function(message, _type)
	for k,v in ipairs(ip) do 
		if string.find(message, v) then 
			handle_match(2)
			cancelEvent()
		end
	end
	for index, val in pairs(insults) do
		local new_val = val:lower();
		local message = message:lower();
		local match = false;
		
		local laufwert = 0;
		if message:len() > new_val:len() then
			laufwert = new_val:len();
		elseif message:len() < new_val:len() then
			laufwert = message:len();
		elseif message:len() == new_val:len() then
			laufwert = new_val:len();
		end	
		
		if ( handle_type == 3 ) then
			 local currentLaufwert = 1;
			 local match = false;
			 local break_schleife = false;
			 laufwert = message:len();
			 local inte_laufwert = 1;
			
			 local search_in_text_match = false
			 while ( inte_laufwert < laufwert+1 and search_in_text_match == false ) do
				 if ( string.byte(tostring(message), inte_laufwert) == string.byte(new_val) ) then
					 search_in_text_match = true
					 if inte_laufwert == 1 then
						 outputDebugString("A");
					 end
				 end
				 inte_laufwert = inte_laufwert+1
			 end
			
			 if search_in_text_match then
				 while ( (currentLaufwert < laufwert+1) and ( break_schleife == false ) ) do
					 if ( string.byte(tostring(message), currentLaufwert+inte_laufwert) ) then
						
						 if ( string.byte(tostring(message), currentLaufwert+inte_laufwert) ~= string.byte(tostring(new_val), currentLaufwert) ) then
							 break_schleife = true
						 else 
							 if ( currentLaufwert >= uebereinstimmungsrate ) then
								 match = true
								 break_schleife = true
							 end
						 end
						
						 currentLaufwert = currentLaufwert+1
					 end
				 end
			 end
		elseif ( handle_type == 2 ) then
			local currentLaufwert = 1;
			local break_schleife = false;
			while ( (currentLaufwert < laufwert+1) and ( break_schleife == false ) ) do
				if ( string.byte(tostring(message), currentLaufwert) ~= string.byte(tostring(new_val), currentLaufwert) ) then
					break_schleife = true
				else 
					if ( currentLaufwert >= uebereinstimmungsrate ) then
						match = true
						break_schleife = true
					end
				end
				
				currentLaufwert = currentLaufwert+1
			end
			
			if ( match ) then
				cancelEvent();
				handle_match(1);
				break;
			end
			
		elseif ( handle_type == 1 ) then
			local currentLaufwert = 1;
			local break_schleife = false;
			while ( (currentLaufwert < laufwert+1) and ( break_schleife == false ) ) do
				if ( string.byte(tostring(message), currentLaufwert) ~= string.byte(tostring(new_val), currentLaufwert) ) then
					break_schleife = true
				else 
					if ( currentLaufwert >= uebereinstimmungsrate ) then
						match = true
						break_schleife = true
					end
				end
				
				currentLaufwert = currentLaufwert+1
			end
		
			if ( match ) then
				cancelEvent();
				handle_match(2);
				break;
			end
		end
			
		
		
	end
end)

function handle_match(_type)
	if ( _type == 1 ) then
		local oriVal = getElementData(source, "b_count")
		if ( oriVal == false ) then
			setElementData(source, "b_count", 1);
			oriVal = 1;
		else
			oriVal = oriVal+1
			setElementData(source, "b_count", oriVal)
		end
		
		if ( oriVal > max_insult ) then
			kickPlayer(source, 'Console', "")
		else
			outputChatBox(string.format("", oriVal, val), source, 255, 0, 0)
		end
	elseif ( _type == 2 ) then
		local rand = math.random(1, #replace_sentence);
		outputChatBox(string.format("", replace_sentence[rand]), root, 255, 255, 255, true);
	end
	clearChatBox(getRootElement())
	for i=1, 30 do
		outputConsole(" ")
	end
	kickPlayer(source, 'Console', "Porque no vas a publicar a otro lado tu servidor de mierda.")
	outputChatBox ("El chat se ha limpiado ",getRootElement(), 67, 196, 220,true )
end