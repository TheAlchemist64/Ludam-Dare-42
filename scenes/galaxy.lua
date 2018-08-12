Star = require "../star"
Trader = require "../trader"
Button = require "../button"

local h3 = 16

local Galaxy = {}

function Galaxy:load (nStars)
  self.stars = {}
  for i=1,nStars do
    local name = "Star "..i
    local x = rng:random(name:len() * 2, width - Star.RADIUS)
    local y = rng:random(Star.RADIUS, height - Star.RADIUS - 60)
    local valid = true
    for _,star in ipairs(self.stars) do
      if distance(x, y, star.x, star.y) < math.max(name:len() * 2, 32) then
        valid = false
      end
    end
    if valid then
      --Generate trader and goods to trade
      local trader = Trader:new("Trader "..i)
      local nGoods = rng:random(1, 3)
      for i=1,nGoods do
        local good = randomKey(goods)
        local q = rng:random(1, MAX_WARE_SUPPLY)
        trader.q[good] = q
      end
      table.insert(self.stars, Star:new(name, x, y, trader))
    end
  end
  self.h3 = love.graphics.newFont(h3)
  local tLabel = "Trade"
  self.trade = Button:new(16, height - 32, tLabel:len() * h3/2 + 12, h3 + 8, tLabel)
  self.trade:setStyle{fSize=h3, padding={4,4}}
end

function Galaxy:update (dt)

end

function Galaxy:draw ()
  for _,star in ipairs(self.stars) do
    star:draw()
    if star.name == player['loc'] then
      local x = star.x
      local y = star.y
      love.graphics.setColor(0,255,0)
      love.graphics.circle("fill", x, y, Star.RADIUS)
      local text = "You"
      local tx = nil
      local ty = nil
      local lineTo = {x=nil, y=nil}
      if x > width - text:len() * 9 then
        tx = x - Star.RADIUS - text:len() * 6
        lineTo.x = x - Star.RADIUS
      else
        tx = x + Star.RADIUS
        lineTo.x = tx
      end
      if y < text:len() * 6 then
        ty = y - 6
      else
        ty = y - Star.RADIUS - 12
      end
      lineTo.y = ty + 6
      love.graphics.line(x, y, lineTo.x, lineTo.y)
      love.graphics.print(text, tx, ty)
    end
  end
  --Draw UI
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("line", 0, height - 48, width, 48)
  self.trade:draw()
end

function mouseInStar (x, y, star)
  return distance(x, y, star.x, star.y) < Star.RADIUS
end

function Galaxy:mousemoved (x, y, dx, dy)
  for _,star in ipairs(self.stars) do
    if mouseInStar(x, y, star) then
      star.hover = true
    else
      star.hover = false
    end
  end
end

function Galaxy:mousereleased (x, y, button)
  if button == 1 then
    for _,star in ipairs(self.stars) do
      if mouseInStar(x, y, star) then
        player['loc'] = star.name
      end
    end
  end
end

return Galaxy
