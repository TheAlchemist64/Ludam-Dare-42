Button = require "Button"

local Trade = {}

local h1 = 24
local h2 = 20
local h3 = 16
local waresY = h1 + h2 + 12 + 3

function Trade:load (loc, trader)
  self.loc = loc
  self.trader = trader
  self.h1 = love.graphics.newFont(h1)
  self.h2 = love.graphics.newFont(h2)
  self.h3 = love.graphics.newFont(h3)
  self.default = love.graphics.newFont()
  self.traderB = {}
  local i = 0
  for ware,q in pairs(self.trader.q) do
    local b = Button:new(width - 40, waresY + i * 20, 20, 20, "+")
    b:setStyle{fSize=h3,padding=2}
    table.insert(self.traderB, b)
    i = i + 1
  end
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
  --Show wares
  love.graphics.setFont(self.h3)
  love.graphics.rectangle("line", 0, waresY, width/2, h3 * MAX_WARE_TYPES)
  love.graphics.rectangle("line", width/2, waresY, width/2, h3 * MAX_WARE_TYPES)
  if next(player.q) then
    local i = 0
    for item, n in pairs(player.q) do
      love.graphics.print(item, 2, waresY + h3 * i)
      i = i + 1
    end
  else
    love.graphics.print("No Wares", 2, waresY)
  end
  if next(self.trader.q) then
    local i = 0
    for item, n in pairs(self.trader.q) do
      love.graphics.print(item, width/2 + 2, waresY + h3 * i)
      i = i + 1
    end
    for _,b in ipairs(self.traderB) do
      b:draw()
    end
  else
    love.graphics.print("No Wares", width/2 + 2, waresY)
  end
end

return Trade
