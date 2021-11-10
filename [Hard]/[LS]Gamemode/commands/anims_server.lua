local anims =
{
	bar =
	{
		{ block = "bar", anim = "barcustom_loop", time = -1 },
		{ block = "bar", anim = "dnk_stndm_loop", time = -1 },
		{ block = "bar", anim = "dnk_stndf_loop", time = -1 },
		{ block = "bar", anim = "barman_idle", time = -1 },
		{ block = "bar", anim = "barserve_bottle", time = 3000 },
		{ block = "bar", anim = "barserve_give", time = 2000 },
		{ { block = "bar", anim = "barserve_in", time = 1000 }, { block = "bar", anim = "barserve_loop", time = -1 } },
	},
	bat =
	{
		{ block = "baseball", anim = "bat_1", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_2", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_3", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_4", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_1", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_2", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_3", time = -1, updatePosition = true, loop = false },
	},
	bomb =
	{
		{ block = "bomber", anim = "bom_plant", time = 3000 },
	},
	crack =
	{
		{ block = "crack", anim = "crckidle2", time = -1 },
		{ block = "crack", anim = "crckidle3", time = -1 },
		{ block = "crack", anim = "crckidle4", time = -1 },
		{ block = "crack", anim = "crckidle1", time = -1 },
	},
	cpr =
	{
		{ block = "medic", anim = "cpr", time = 8000 },
	},
	bailar =
	{
		{ block = "dancing", anim = "dance_loop", time = -1 },
		{ block = "dancing", anim = "dan_down_a", time = -1 },
		{ block = "dancing", anim = "dan_left_a", time = -1 },
		{ block = "dancing", anim = "dan_loop_a", time = -1 },
		{ block = "dancing", anim = "dan_right_a", time = -1 },
		{ block = "dancing", anim = "dan_up_a", time = -1 },
		{ block = "dancing", anim = "dnce_M_a", time = -1 },
		{ block = "dancing", anim = "dnce_M_b", time = -1 },
		{ block = "dancing", anim = "dnce_M_c", time = -1 },
		{ block = "dancing", anim = "dnce_M_d", time = -1 },
		{ block = "dancing", anim = "dnce_M_e", time = -1 },
	},
	fix =
	{
		{ block = "car", anim = "fixn_car_loop", time = -1, updatePosition = false },
	},
	flag =
	{
		{ block = "car", anim = "flag_drop", time = 3000 },
	},
	gsign =
	{
		{ block = "ghands", anim = "gsign1", time = 4000 },
		{ block = "ghands", anim = "gsign1lh", time = 4000 },
		{ block = "ghands", anim = "gsign2", time = 4000 },
		{ block = "ghands", anim = "gsign2lh", time = 4000 },
		{ block = "ghands", anim = "gsign3", time = 4000 },
		{ block = "ghands", anim = "gsign3lh", time = 4000 },
		{ block = "ghands", anim = "gsign4", time = 4000 },
		{ block = "ghands", anim = "gsign4lh", time = 4000 },
		{ block = "ghands", anim = "gsign5", time = 4000 },
		{ block = "ghands", anim = "gsign5lh", time = 4000 },
		{ block = "ghands", anim = "gsign1", time = 4000 },
	},
	hablar =
	{
		{ block = "gangs", anim = "prtial_gngtlka", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkb", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkc", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkd", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlke", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkf", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkg", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkh", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkh", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkb", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkc", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkd", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlke", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkf", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkg", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkh", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkh", time = 4000 },
	},
	gym =
	{
		{ block = "gymnasium", anim = "gym_bike_still", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_bike_slow", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_bike_pedal", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_bike_fast", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_bike_faster", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_tread_tired", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_tread_walk", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_tread_jog", time = -1, updatePosition = false },
		{ block = "gymnasium", anim = "gym_tread_sprint", time = -1, updatePosition = false },
	},
	provocar =
	{
		{ block = "dealer", anim = "dealer_idle", time = -1 },
		{ block = "dealer", anim = "dealer_idle_02", time = -1 },
		{ block = "dealer", anim = "dealer_idle_02", time = -1 },
		{ block = "dealer", anim = "dealer_idle_03", time = -1 },
		{ block = "fat", anim = "fatidle", time = -1 },
		{ block = "gangs", anim = "dealer_idle", time = -1 },
	},
	besar =
	{
		{ block = "kissing", anim = "grlfrd_kiss_01", time = 4000 },
		{ block = "kissing", anim = "grlfrd_kiss_02", time = 5000 },
		{ block = "kissing", anim = "grlfrd_kiss_03", time = 6000 },
		{ block = "kissing", anim = "playa_kiss_01", time = 4000 },
		{ block = "kissing", anim = "playa_kiss_02", time = 5000 },
		{ block = "kissing", anim = "playa_kiss_03", time = 6000 },
	},
	tirarse =
	{
		{ block = "beach", anim = "sitnwait_loop_w", time = -1 },
		{ block = "beach", anim = "lay_bac_loop", time = -1 },
		{ block = "int_house", anim = "bed_loop_l", time = -1 },
		{ block = "int_house", anim = "bed_loop_r", time = -1 },
	},
	recostar =
	{
		{ block = "gangs", anim = "leanidle", time = -1 },
	},
	no =
	{
		{ block = "gangs", anim = "invite_no", time = 4000 },
	},
	pose =
	{
		{ block = "clothes", anim = "clo_pose_torso", time = -1 },
		{ block = "clothes", anim = "clo_pose_shoes", time = -1 },
		{ block = "clothes", anim = "clo_pose_legs", time = -1 },
		{ block = "clothes", anim = "clo_pose_watch", time = -1 },
	},
	sentar =
	{
		{ block = "ped", anim = "seat_idle", time = -1 },
		{ block = "food", anim = "ff_Sit_eat1", time = -1 },
		{ block = "beach", anim = "parksit_m_loop", time = -1 },
		{ block = "beach", anim = "parksit_w_loop", time = -1 },
		{ block = "sunbathe", anim = "parksit_m_idlec", time = -1 },
		{ block = "sunbathe", anim = "parksit_w_idlea", time = -1 },
		{ { block = "attractors", anim = "stepsit_in", time = 1200 }, { block = "attractors", anim = "stepsit_loop", time = -1 } },
		{ block = "int_house", anim = "lou_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_drink", time = -1 },
		{ block = "int_office", anim = "off_sit_idle_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_read", time = -1 },
		{ block = "int_office", anim = "off_sit_type_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_watch", time = -1 },
		{ block = "jst_buisness", anim = "girl_02", time = -1 },
	},
	fumar =
	{
		{ block = "lowrider", anim = "m_smkstnd_loop", time = -1 },
		{ block = "lowrider", anim = "m_smklean_loop", time = -1 },
		{ block = "lowrider", anim = "f_smklean_loop", time = -1 },
		{ block = "gangs", anim = "smkcig_prtl", time = -1 },
	},
	observar =
	{
		{ block = "cop_ambient", anim = "coplook_think", time = -1 },
	},
	vomitar =
	{
		{ block = "food", anim = "eat_vomit_p", time = 7000 },
	},
	cansado =
	{
		{ block = "fat", anim = "idle_tired", time = -1 },
	},
	cruzar =
	{
		{ block = "cop_ambient", anim = "coplook_loop", time = -1 },
	},
	saludo =
	{
		{ block = "kissing", anim = "bd_gf_wave", time = 4000 },
		{ block = "kissing", anim = "gfwave2", time = 2500 },
	},
	si =
	{
		{ block = "gangs", anim = "invite_yes", time = 4000 },
	},
	caer =
	{
		{ block = "ped", anim = "FLOOR_hit", time = 1000000000000000000000 },
		{ block = "ped", anim = "FLOOR_hit_f", time = 1000000000000000000000 },
	},
}


local function setAnim( player, anim )
	if isElement( player ) and anim and not isPedInVehicle( player ) then
		setPedAnimation( player, anim.block, anim.anim, -1,true, false, false)
		player:setData("animPlayer", true)
	end
end


local function playAnim( player, anim )
	local time = 0	
	for key, value in ipairs( anim ) do
		if time == 0 then
			setAnim( player, value )
		else
			setTimer( setAnim, time, 1, player, value )
		end
		
		if value.time == -1 then
			time = 0
			break
		else
			time = time + value.time
		end
	end
end

-- Key animations

for key, value in pairs( anims ) do
	addCommandHandler( key,
		function( player, commandName, num )
			local anim = tonumber( num ) and value[ tonumber( num ) ] or value[ anim ] or #value == 0 and value or value[ 1 ]
			
			if #anim == 0 then
				anim = { anim }
			end
				
			playAnim( player, anim )
		end
	)
end

-- Stop animation
function stopAnim( player )
	if not player:getData("Roleplay:get_dead") == true then
		if player:getData("animPlayer") == true then
			setPedAnimation( player )
			player:setData("animPlayer", false)
		end
	end
end

addEventHandler("onResourceStart", resourceRoot, function()
	for _, player in ipairs(Element.getAllByType("player")) do
		bindKey(player, "space", "down", stopAnim)
		player:setData("animPlayer", false)
	end
end)

addEventHandler("onPlayerJoin", getRootElement(), function()
	bindKey(source, "space", "down", stopAnim)
	source:setData("animPlayer", false)
end)


-- Removes a players animation
addCommandHandler( {"parar"}, stopAnim )

-- Triggered when pressing 'space' as client
addEvent( "anims:reset", true )
addEventHandler( "anims:reset", root,
	function( )
		if client == source then
			stopAnim( source )
		end
	end
)

--

-- Animation help/commands
addCommandHandler( {"anim", "animacion"},
	function ( player, commandName, block, anim )
		if not notIsGuest( player ) then
			outputChatBox( "#7A7979/bar 1-7 /bat 1-7 /bomb /crack 1-4 /cpr /bailar 1-11 /fix", player, 255, 255, 255, true  )
			outputChatBox( "#7A7979/flag /gsign 1-11 /hablar 1-17 /gym 1-9 /provocar 1-6 /besar 1-6", player, 255, 255, 255, true  )
			outputChatBox( "#7A7979/tirarse 1-4 /recostar /no /pose 1-4 /sentar 1-14 /fumar 1-4 /observar", player, 255, 255, 255, true  )
			outputChatBox( "#7A7979/vomitar /cansado /cruzar /saludo 1-2 /si /caer 1-2 /sentar 1-17", player, 255, 255, 255, true )
		end
	end
)