doors = {
--[[ primera puerta
{
{text="Marcador", pos={228.74670410156, 149.8078918457, 1003.0234375}, dim=0, int=3, job="Policia"},
{text="Object", id=3089, pos={228.3, 150.2, 1003.4}, move={228.3, 148.2, 1003.4}, rot={0, 0, 90}, dim=0, int=3},
{text="Salida", pos={227.74711608887, 149.77172851563, 1003.0234375}, dim=0, int=3, job="Policia"},
},
segunda puerta
{
{text="Marcador", pos={228.75259399414, 159.83076477051, 1003.0234375}, dim=0, int=3, job="Policia"},
{text="Object", id=3089, pos={228.3, 160.2, 1003.4}, move={228.3, 158.2, 1003.4}, rot={0, 0, 90}, dim=0, int=3},
{text="Salida", pos={227.74786376953, 159.80010986328, 1003.0234375}, dim=0, int=3, job="Policia"},
},
 tercera puerta
{
{text="Marcador", pos={230.11459350586, 169.35296630859, 1003.0234375}, dim=0, int=3, job="Policia"},
{text="Object", id=3089, pos={230.5, 169.8, 1003.4}, move={228.5, 169.8, 1003.4}, rot={0, 0, 0}, dim=0, int=3},
{text="Salida", pos={230.08905029297, 170.35145568848, 1003.0305786133}, dim=0, int=3, job="Policia"},
},
 cuarta puerta
{
{text="Marcador", pos={228.69389343262, 157.54791259766, 1003.0234375}, dim=0, int=3, job="Policia"},
{text="Object", id=3089, pos={228.967, 158.10001, 1003.4}, move={225.967, 158.10001, 1003.4}, rot={0, 0, 0}, dim=0, int=3},
{text="Salida", pos={229.68869018555, 158.78381347656, 1003.0234375}, dim=0, int=3, job="Policia"},
},
 quinta puerta
{
{text="Marcador", pos={274.24407958984, 188.57252502441, 1007.171875}, dim=0, int=3, job="Policia"},
{text="Object", id=3089, pos={274.60001, 189.3, 1007.5}, move={272.60001, 189.3, 1007.5}, rot={0, 0, 0}, dim=0, int=3},
{text="Salida", pos={274.18222045898, 189.95208740234, 1007.171875}, dim=0, int=3, job="Policia"},
},
sexta puerta
{
{text="Marcador", pos={295.22875976563, 189.94993591309, 1007.171875}, dim=0, int=3, job="Policia"},
{text="Object", id=3089, pos={295.60001, 189.3, 1007.5}, move={293.60001, 189.3, 1007.5}, rot={0, 0, 0}, dim=0, int=3},
{text="Salida", pos={295.16970825195, 188.85224914551, 1007.171875}, dim=0, int=3, job="Policia"},
},
 septima puerta
{
{text="Marcador", pos={251.4482421875, 75.014541625977, 1003.640625}, dim=0, int=6, job="Policia"},
{text="Object", id=3089, pos={252.2, 74.8, 1004}, move={252.2, 76.8, 1004}, rot={0, 0, 270}, dim=0, int=6},
{text="Salida", pos={252.84761047363, 74.977546691895, 1003.640625}, dim=0, int=6, job="Policia"},
},
]]
}

--[[
 posX="252.2" posY="74.8" posZ="1004" rotX="0" rotY="0" rotZ="270"></object>

]]

function getDoors()
	return doors
end
