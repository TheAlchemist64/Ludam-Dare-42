local Trade = {}

function Trade:load (loc, trader)
  self.loc = loc
  self.trader = trader
  self.h1 = love.graphics.newFont(24)
end

function Trade:update (dt)
  -- body...
end

function Trade:draw ()
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(self.h1)
  love.graphics.print(self.loc, width / 2 - self.loc:len() * 6, 0)
end

return Trade
