function getMyCode()
	local my_code = [[
		functions_exports = {}
		functions_exports.__index = functions_exports


		function import(...)
			return functions_exports:new(...)
		end

		function functions_exports:new(functions)
			if #functions == 0 then
				return iprint 'No hay Funciones a Exportar'
			end
			local instance = {functions = functions}
			setmetatable(instance, self)
			return instance
		end

		function functions_exports:init(resource)
			local res = Resource.getFromName(resource)
			if (res) then
				local functions = res:getExportedFunctions()
				if (#functions > 0) then
					local loads = {}
					if self['functions']:find('*') then
						loads = functions
					else
						for k,v in pairs(split(self['functions'],',')) do
							if table.find(functions, v) then
								table.insert(loads, v)
							end
						end
					end
					for i,v in ipairs(loads) do
						_G[v] = function(...) return call(res, v, ...) end
					end
				end
			end
		end

		function table.find(t,value)
			for k,v in pairs(t) do
				if (v == value) then
					return true
				end
			end
			return false
		end]]
	return my_code
end