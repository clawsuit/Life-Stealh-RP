if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

function createNewBlip(x, y, z, iconString, int, dim, size, r, g, b, visibleDistance, visibleTo)
	local blip = createElement('NuevoBlip')
	if blip then
		local datos = {
			iconString = iconString,
			size=size or 1,
			r=r or 255,
			g=g or 255,
			b=b or 255,
			distance=visibleDistance or 65535,
			visibleTo= visibleTo or 'all',
			type='server',
		}
		setElementPosition( blip, x, y, z )
		setElementInterior( blip, int )
		setElementDimension( blip, dim )
		setDato(blip, 'BlipData', datos)
		return blip
	end
	return false
end

function createNewBlipAttachedTo(elementToAttachTo, iconString, size, r, g, b, visibleDistance,visibleTo)
	local blip = createElement('NuevoBlip')
	if blip then
		local datos = {
			AttachTo = elementToAttachTo or false,
			iconString = iconString,
			size=size or 1,
			r=r or 255,
			g=g or 255,
			b=b or 255,
			distance=visibleDistance or 65535,
			visibleTo= visibleTo or 'all',
			type='server'
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

--createNewBlipAttachedTo(getPlayerFromName( 'Claw_Suit' ), 'gasolinera', 1, nil, nil, nil)
