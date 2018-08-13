local Trader = {}

function Trader:new(name)
  local o = {name = name, credits = TRADER_DEFAULT_MONEY, q={}, price={}}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Trader:getNewWareCount(potential)
  local q = {}
  for ware,n in pairs(self.q) do
    q[ware] = true
  end
  for ware,n in pairs(potential) do
    q[ware] = true
  end
  local count = 0
  for ware,bool in pairs(q) do
    count = count + 1
  end
  return count
end

return Trader
