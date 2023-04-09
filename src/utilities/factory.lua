function Factory( obj ) -- for Inheritance 
    function obj:new( o )
        o = o or {}
        setmetatable( o, self )
        self.__index = self
        return o
    end
    return obj
end
