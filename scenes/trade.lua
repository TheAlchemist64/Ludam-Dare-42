local Trade = {}

local h1 = 24
local h2 = 20
local h3 = 16

function Trade:load (loc, trader)
  self.loc = loc
  self.trader = trader
  self.h1 = love.graphics.newFont(h1)
  self.h2 = love.graphics.newFont(h2)
  self.h3 = love.graphics.newFont(h3)
  self.default = love.graphics.newFont()
end

function Trade:update (dt)
  -- body...
end

function Trade:draw ()
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(self.h1)
  love.graphics.print(self.loc, width / 2 - self.loc:len() * h1/4, 0)
  love.graphics.setFont(self.h2)
  love.graphics.rectangle("line", 0, h1 + 3, width/2, h2 + 12)
  love.graphics.print(player.name, width/4 - player.name:len() * h2/4, h1)
  love.graphics.rectangle("line", width/2, h1 + 3, width/2, h2 + 12)
  love.graphics.print(self.trader.name, width * 0.75 - self.trader.name:len() * h2/4, h1)
  love.graphics.setFont(self.default)
  local pc = player.credits.." credits"
  love.graphics.print(pc, width/4 - pc:len() * 3, h1 + h2)
  local tc = self.trader.credits.." credits"
  love.graphics.print(tc, width * 0.75 - tc:len() * 3, h1 + h2)
end

return Trade
