Star = require "../star"
Trader = require "../trader"

local h3 = 16

local Galaxy = {}

function Galaxy:generate (nStars)
  self.stars = {}
  for i=1,nStars do
    local name = nil
    if i == 1 then
      name = "Jav'n"
    else
      name = "Star "..i
    end
    local x = rng:random(name:len() * 2, width - Star.RADIUS)
    local y = rng:random(Star.RADIUS + 18, height - Star.RADIUS - 60)
    local valid = true
    for _,star in ipairs(self.stars) do
      if distance(x, y, star.x, star.y) < math.max(name:len() * 2, 32) then
        valid = false
      end
    end
    if valid then
      local trader = nil
      local star = Star:new(name, x, y, nil, false)
      if i == 1 then
        trader = Trader:new("Fueling Station")
        trader.q['Fuel'] = 10
        star.prices['Fuel'] = 2
      elseif i > 1 and i < 4 then
        local tName = nil
        if i == 2 then
          tName = "Scooter"
        else
          tName = "Mikey"
        end
        trader = Trader:new(tName)
        trader.q['Powder'] = rng:random(1, MAX_WARE_SUPPLY)
        star.prices['Powder'] = calcPrice('Powder', trader.q['Powder'])
        star.black_market = true
      else
        --Generate trader and goods to trade
        trader = Trader:new("Trader "..i)
        local nGoods = rng:random(1, 3)
        local j = 1
        while j <= nGoods do
          local good = randomKey(goods)
          if not inTable(contraband, good) then
            local q = rng:random(1, MAX_WARE_SUPPLY)
            trader.q[good] = q
            star.prices[good] = calcPrice(good, q) --price is inverse to supply
            j = j + 1
          end
        end
      end
      star.trader = trader
      table.insert(self.stars, star)
    end
  end
  self.h3 = love.graphics.newFont(h3)
  self.default = love.graphics.newFont()
  local tLabel = "Trade"
  self.trade = Button:new(16, height - 32, tLabel:len() * h3/2 + 12, h3 + 8, tLabel)
  self.trade:setStyle{fSize=h3, padding={4,4}}
  self.curStar = self.stars[1]
end

function Galaxy:findStarByName (name)
  for _,star in ipairs(self.stars) do
    if star.name == name then
      return star
    end
  end
  return nil
end

function Galaxy:restock ()
  for i,star in ipairs(self.stars) do
    star.trader.q = {}
    if i == 1 then
      star.trader.q['Fuel'] = 10
    elseif i > 1 and i < 4 then
      star.trader.q['Powder'] = rng:random(1, MAX_WARE_SUPPLY)
      star.prices['Powder'] = calcPrice('Powder', star.trader.q['Powder'])
    else
      --Generate goods to trade
      local nGoods = rng:random(1, 3)
      local j = 1
      while j <= nGoods do
        local good = randomKey(goods)
        if not inTable(contraband, good) then
          local q = rng:random(1, MAX_WARE_SUPPLY)
          star.trader.q[good] = q
          star.prices[good] = calcPrice(good, q) --price is inverse to supply
          j = j + 1
        end
      end
    end
    star.trader.credits = math.max(star.trader.credits, TRADER_DEFAULT_MONEY)
  end
end

function Galaxy:load (nStars)
  if nStars then
    self:generate(nStars)
  end
end

function Galaxy:update (dt)

end

function Galaxy:draw ()
  love.graphics.setFont(self.default)
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
  -- Top
  love.graphics.setFont(self.h3)
  love.graphics.print("Credits: "..player.credits, 0, 0)
  local f = "Fuel: "..player.q['Fuel']
  love.graphics.print(f, width/2 - f:len() * h3/4, 0)
  local timeLeft = TIME_LIMIT + 1 - day
  local tlText = timeLeft.." days left"
  love.graphics.print(tlText, width - tlText:len() * h3/2, 0)
  -- Bottom
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
      local fuel = player.q['Fuel']
      if mouseInStar(x, y, star) and fuel > 0 then
        player['loc'] = star.name
        player.q['Fuel'] = fuel - 1
        if player.q['Fuel'] == 3 then
          local body = "You are running out of fuel. You have three days to restock before you strand yourself at a star (Game Over)."
          Director:pushModal(Confirm:new(400, 100, "Warning: Low on Fuel!", body))
        end
        self.curStar = star
        day = day + 1
        if day == (TIME_LIMIT + 1) and player.credits < GOAL then
          Director:changeScene(GameOver)
        elseif day % 7 == 1 then
          self:restock()
          local body = "Markets around the galaxy have restocked with new goods."
          Director:pushModal(Confirm:new(400, 100, "Market Update", body))
        end
      end
      if self.trade:clicked(x, y) then
        if not player.q['Powder'] or player.q['Powder'] < 1 or
        self.curStar.black_market==true then
          Director:changeScene(Trade, player['loc'], self.curStar.trader)
        else
          local body = "Sorry, but I don't want the Galactic Police crawling over my shop anytime soon."
          Director:pushModal(Confirm:new(400, 100, "Contraband!", body))
        end
      end
    end
  end
end

return Galaxy
