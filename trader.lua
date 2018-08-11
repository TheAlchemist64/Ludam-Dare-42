local Trader = {}

function Trader:new()
  local o = {credits = 1000, q={}, price={}}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Trader:sell(good, q, trader)
  assert(q <= self.q[good],
    "Tried to sell "..q.." "..good.." when trader only had "..self.q[good])
  assert(trader.credits >= self.price[good],
    "Buyer had insufficient credits: "..trader.credits.."/"..self.price[good])
  self.q[good] = self.q[good] - q
  if not trader.q[good] then
    trader.q[good] = 0
  end
  trader.q[good] = trader.q[good] + q
  self.credits = self.credits + self.price[good] * q
  trader.credits = trader.credits - self.price[good] * q
end

function Trader:buy(good, q, trader)
  assert(q <= trader.q[good],
    "Tried to buy "..q.." "..good.." when trader only had "..self.q[good])
  assert(self.credits >= trader.price[good],
    "Buyer had insufficient credits: "..self.credits.."/"..trader.price[good])
  trader.q[good] = trader.q[good] - q
  if not self.q[good] then
    self.q[good] = 0
  end
  self.q[good] = self.q[good] + q
  trader.credits = trader.credits + trader.price[good] * q
  self.credits = self.credits - trader.price[good] * q
end

return Trader
