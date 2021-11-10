function setDato(element, key, value)
    if element then
        if type(key) == 'string' then
            if value then
                local array = fromJSON( element:getID() ) or {}
                array[key] = value    
                return element:setID(toJSON( array ))
            end
        end
    end
    return false;
end

function getDato(element,key)
    if element then
        if type(key) == 'string' then
            if value then
                local array = fromJSON( getElementID(element) )
                if array and type(array) == 'table' then
                    if array[key] then
                        return array[key]
                    end
                end
            end
        end
    end
    return false;
end

function getDatos(element)
    return element and fromJSON( element:getID() ) or false
end