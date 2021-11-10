function getMapFromWorldPosition(pX,pY)
    if isPlayerMapVisible() then
        local minX, minY, maxX, maxY = getPlayerMapBoundingBox(  )
        local x = (pX - (-3000)) / 6000
        local y = -(pY - 3000) / 6000
        return ((1-x)*minX)+(x*maxX), ((1-y)*minY)+(y*maxY)
    end
    return false;
end