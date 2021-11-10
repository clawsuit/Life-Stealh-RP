if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return 
end

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

local screenW, screenH = guiGetScreenSize(  )

local px,py = 1037.501953125, -1572.6787109375
local S = 24

addEventHandler( "onClientRender", getRootElement(), 
	function()
		if isPlayerMapVisible() then
			for i,blip in ipairs(Element.getAllByType('NuevoBlip',getResourceDynamicElementRoot(resource))) do
				if blip then
					local v = getDato(blip, 'BlipData') or false
					if v then
						if v.type == 'server' then
							if v.visibleTo == 'all' or type(v.visibleTo) == 'userdata' and (v.visibleTo == localPlayer) then
								if v.AttachTo then
									setElementPosition( blip, getElementPosition( v.AttachTo ) )
									setElementInterior( blip, getElementInterior( v.AttachTo ) )
									setElementDimension( blip, getElementDimension( v.AttachTo ) )
								end
								if getElementInterior( blip ) == getElementInterior( localPlayer ) and getElementDimension( blip ) == getElementDimension( localPlayer ) then
									local px,py,pz = getElementPosition( localPlayer )
									local bx,by,bz = getElementPosition( blip )
									--if getDistanceBetweenPoints3D(px,py,pz, bx,by,bz ) <= v.distance then
									
										local X,Y = getMapFromWorldPosition(bx,by)
										dxDrawImage( X-((S*v.size)/2), Y-((S*v.size)/2), S*v.size, S*v.size, 'images/'..(v.iconString)..'.png', 0,0,0, tocolor(v.r,v.g,v.b, 255), false)
										
									--end
								end
							end
						elseif v.type == 'client' then
							if v.AttachTo then
								setElementPosition( blip, getElementPosition( v.AttachTo ) )
								setElementInterior( blip, getElementInterior( v.AttachTo ) )
								setElementDimension( blip, getElementDimension( v.AttachTo ) )
							end
							if getElementInterior( blip ) == getElementInterior( localPlayer ) and getElementDimension( blip ) == getElementDimension( localPlayer ) then
								local px,py,pz = getElementPosition( localPlayer )
								local bx,by,bz = getElementPosition( blip )
								--if getDistanceBetweenPoints3D(px,py,pz, bx,by,bz ) <= v.distance then
								
									local X,Y = getMapFromWorldPosition(bx,by)
									dxDrawImage( X-((S*v.size)/2), Y-((S*v.size)/2), S*v.size, S*v.size, 'images/'..(v.iconString)..'.png', 0,0,0, tocolor(v.r,v.g,v.b, 255), false)
									
								--end
							end
						end
					end
				end
			end
		end
	end
)

function createNewBlip(x, y, z, iconString, int, dim, size, r, g, b, visibleDistance)
	local blip = createElement('NuevoBlip')
	if blip then
		local datos = {
			iconString = iconString,
			size=size or 1,
			r=r or 255,
			g=g or 255,
			b=b or 255,
			distance=visibleDistance or 65535,
			type='client'
		}
		setElementPosition( blip, x, y, z )
		setElementInterior( blip, int )
		setElementDimension( blip, dim )
		setDato(blip, 'BlipData', datos)
		return blip
	end
	return false
end


function createNewBlipAttachedTo(elementToAttachTo, iconString,size, r, g, b, visibleDistance)
	local blip = createElement('NuevoBlip')
	if blip then
		local datos = {
			AttachTo = elementToAttachTo or false,
			iconString = iconString,
			size=size or 1,
			r=r or 255,
			g=g or 255,
			b=b or 255,
			distance=visibleDistance or 16383.0,
			type='client'
		}
		setElementPosition( blip, getElementPosition( elementToAttachTo ) )
		setElementInterior( blip, getElementInterior( elementToAttachTo ) )
		setElementDimension( blip, getElementDimension( elementToAttachTo ) )
		setDato(blip, 'BlipData', datos)
		attachElements(blip, elementToAttachTo)
		return blip
	end
	return false
end



function getMapFromWorldPosition(pX,pY)
	if isPlayerMapVisible() then
		local minX, minY, maxX, maxY = getPlayerMapBoundingBox(  )
		local x = (pX - (-3000)) / 6000
		local y = -(pY - 3000) / 6000
		return ((1-x)*minX)+(x*maxX), ((1-y)*minY)+(y*maxY)
	end
	return false;
end



