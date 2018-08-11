local Trader = {}

function Trader:new(name)
  local o = {name = name, credits = 1000, q={}, price={}}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Trader:sell(good, q, price, trader)
  assert(q <= self.q[good],
    "Tried to sell "..q.." "..good.." when "..self.name.." only had "..self.q[good])
  assert(trader.credits >= price * q,
    trader.name.." had insufficient credits: "..trader.credits.."/"..(price * q))
  self.q[good] = self.q[good] - q
  if not trader.q[good] then
    trader.q[good] = 0
  end
  trader.q[good] = trader.q[good] + q
  self.credits = self.credits + price * q
  trader.credits = trader.credits - price * q
end

return Trader
