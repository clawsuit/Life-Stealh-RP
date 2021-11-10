local tTimer    -- Transition Timer
local timer1    -- Warp Camera to Transition Start Point Timer
local timer2    -- Fade Camera In
local fTimer    -- Fade Camera Out

local TRANSITION_TIME = 20000

local trans = {
-- Los Santos
{ matrix1={81.762649536133, -1860.951171875, 55.058815002441, 181.08654785156, -1854.1516113281, 55.058815002441},
    matrix2={730.4931640625, -1861.8348388672, 15.542729377747, 830.33386230469, -1864.9422607422, 15.542729377747} }, -- Grove Street
{ matrix1={2689.9301757813, -1667.0987548828, 56.929039001465, 2592.3127441406, -1668.0919189453, 56.929039001465},
    matrix2={2357.5654296875, -1659.0106201172, 16.761831283569, 2258.0476074219, -1658.4602050781, 16.761831283569} }, -- LS Police Dept.
{ matrix1={2881.527, -2278.559, 65.569, 2880.718, -2279.290, 65.066},
    matrix2={2889.208, -2584.543, 65.297, 2887.876, -2583.550, 64.604} }, -- Ocean Docks
{ matrix1={2045.397, -2327.580, 82.291, 2044.889, -2326.976, 81.387},
    matrix2={1597.129, -2705.626, 82.291, 1596.791, -2705.223, 81.688} }, -- LS Airport
{ matrix1={369.900, -1940.950, 9.023, 369.929, -1944.547, 9.161},
    matrix2={307.285, -2051.150, 40.873, 308.203, -2051.158, 40.476} }, -- Santa Maria Pier
{ matrix1={1310.700, -1403.519, 50.871, 1309.646, -1403.872, 50.419},
    matrix2={1254.105, -1232.171, 51.248, 1251.821, -1232.938, 50.269} }, -- All Saints Hospital
{ matrix1={1419.854, -1301.385, 51.697, 1421.395, -1301.373, 51.268},
    matrix2={1693.813, -1300.860, 22.372, 1695.408, -1300.848, 22.243} }, -- Downtown LS Grnd
{ matrix1={1411.175, -2036.013, 161.715, 1409.126, -2036.018, 160.913},
    matrix2={1137.425, -2037.162, 71.914, 1136.627, -2037.164, 71.860} }, -- Verdant Bluffs
{ matrix1={1415.640, -810.827, 82.045, 1415.613, -810.234, 81.959},
    matrix2={1432.792, -914.792, 98.513, 1432.629, -914.215, 98.496} }, -- Vinewood
{ matrix1={1832.260, -1622.243, 34.163, 1832.007, -1621.933, 34.161},
    matrix2={1646.111, -1387.090, 128.211, 1644.955, -1385.599, 128.878} }, -- LS Skyline
}

-- Funciones --


function areTransitionsRunning()
    if (tTimer) then return true else return false end
end

function iniciarTransicion()
    tTimer = setTimer(triggerNextTransitions, TRANSITION_TIME, 0)
    triggerNextTransitions()
    fadeCamera(false, 0)
    addEventHandler("onClientPreRender", root, renderCameraMovement)
end

function detenerTransicion()
    if isTimer(tTimer) then
    	killTimer(tTimer)
    end
    if isTimer(timer1) then killTimer(timer1) end
    if isTimer(timer2) then killTimer(timer2) end
    if isTimer(fTimer) then killTimer(fTimer) end
    --fadeCamera(true, 0)
    removeEventHandler("onClientPreRender", root, renderCameraMovement)
    
    tTimer = false
    timer1 = false
    timer2 = false
    fTimer = false
    tSound = false
    fadeCamera(true, 1)
end
addEvent("detenerTransicion", true)
addEventHandler("detenerTransicion", root, detenerTransicion)

local oldLoc = 0
function triggerNextTransitions()
    if isTimer(timer1) then killTimer(timer1) end
    if isTimer(timer2) then killTimer(timer2) end
    loc = math.random(#trans)
    if loc == oldLoc then triggerNextTransitions() end
    timer1 = setTimer(setCameraMatrix, 500, 1, trans[loc].matrix1[1], trans[loc].matrix1[2], trans[loc].matrix1[3], trans[loc].matrix1[4], trans[loc].matrix1[5], trans[loc].matrix1[6])
    timer2 = setTimer(fadeCamera, 1000, 1, true)
    fTimer = setTimer(fadeCamera, TRANSITION_TIME-1100, 1, false, 1)
    oldLoc = loc
end

function renderCameraMovement()
    if isTimer(tTimer) and not isTimer(timer1) then
        local rTime = getTimerDetails(tTimer)+1000
        local x1, y1, z1, lx1, ly1, lz1 = trans[loc].matrix1[1], trans[loc].matrix1[2], trans[loc].matrix1[3], trans[loc].matrix1[4], trans[loc].matrix1[5], trans[loc].matrix1[6]
        local x2, y2, z2, lx2, ly2, lz2 = trans[loc].matrix2[1], trans[loc].matrix2[2], trans[loc].matrix2[3], trans[loc].matrix2[4], trans[loc].matrix2[5], trans[loc].matrix2[6]
        setCameraMatrix((((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(x2-x1))+x1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(y2-y1))+y1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(z2-z1))+z1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(lx2-lx1))+lx1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(ly2-ly1))+ly1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(lz2-lz1))+lz1)
        local sW,sH = guiGetScreenSize()
        --dxDrawRectangle(0, 0, sW, sH*0.12, tocolor(0,0,0,255))
        --dxDrawRectangle(0, sH*0.88, sW, sH, tocolor(0,0,0,255))
    end
end
