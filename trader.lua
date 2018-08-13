local Trader = {}

function Trader:new(name)
  local o = {name = name, credits = TRADER_DEFAULT_MONEY, q={}, price={}}
  setmetatable(o, self)
  self.__index = self
  return o
end

return Trader
