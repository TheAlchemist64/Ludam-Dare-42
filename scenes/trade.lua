local Trade = {}

local h1 = 24
local h2 = 20
local h3 = 16
local waresY = h1 + h2 + 12 + 3
local dealY = waresY + (h3 + 2) * MAX_WARE_TYPES
local dealT = dealY + h2 + 2
local finalY = dealT + (h3 + 2) * MAX_WARE_TYPES

function loadButtons ()
  Trade.playerB = {}
  Trade.traderB = {}
  local i = 0
  for ware,q in pairs(player.q) do
    local pb = Button:new(width/2 - 28, waresY + i * 18, 14, 18, "+")
    local mb = Button:new(width/2 - 14, waresY + i * 18, 14, 18, "-")
    pb:setStyle{fSize=h3}
    mb:setStyle{fSize=h3, padding={4,0}}
    pb['side'] = 'player'
    pb['inv'] = player.q
    pb['ware'] = ware
    pb['change'] = -1
    mb['side'] = 'player'
    mb['inv'] = player.q
    mb['ware'] = ware
    mb['change'] = 1
    table.insert(Trade.playerB, pb)
    table.insert(Trade.playerB, mb)
    i = i + 1
  end
  i = 0
  for ware,q in pairs(Trade.trader.q) do
    local pb = Button:new(width - 28, waresY + i * 18, 14, 18, "+")
    local mb = Button:new(width - 14, waresY + i * 18, 14, 18, "-")
    pb:setStyle{fSize=h3}
    mb:setStyle{fSize=h3, padding={4,0}}
    pb['side'] = 'trader'
    pb['inv'] = Trade.trader.q
    pb['ware'] = ware
    pb['change'] = -1
    mb['side'] = 'trader'
    mb['inv'] = Trade.trader.q
    mb['ware'] = ware
    mb['change'] = 1
    table.insert(Trade.traderB, pb)
    table.insert(Trade.traderB, mb)
    i = i + 1
  end
end

function Trade:load (loc, trader)
  self.loc = loc
  self.trader = trader
  self.prices = Galaxy:findStarByName(loc).prices
  self.h1 = love.graphics.newFont(h1)
  self.h2 = love.graphics.newFont(h2)
  self.h3 = love.graphics.newFont(h3)
  self.default = love.graphics.newFont()
  loadButtons()
  self.deal={player={}, trader={}}
  self.reset = Button:new(width/2 - 75, finalY + h3, 75, h3 + 2, "Reset")
  self.reset:setStyle{fSize=h3, padding={16,0}}
  self.confirm = Button:new(width/2, finalY + h3, 75, h3 + 2, "Confirm")
  self.confirm:setStyle{fSize=h3, padding={6,0}}
  local label = "Exit"
  self.exit = Button:new(width/2 - label:len() * h3/2, finalY + h3 * 2 + 2, label:len() * h3, h3 + 4, label)
  self.exit:setStyle{fSize=h3, padding={label:len() * h3/4,2}}
  self.total = 0
end

function Trade:update (dt)
  self.total = 0
  for item, n in pairs(self.deal['player']) do
    if n > 0 then
      if self.prices[item] then
        self.total = self.total + self.prices[item] * n
      else
        self.total = self.total + medianPrice() * n
      end
    end
  end
  for item, n in pairs(self.deal['trader']) do
    if n > 0 then
      self.total = self.total - self.prices[item] * n
    end
  end
end

function Trade:draw ()
  --Show headers
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
  love.graphics.rectangle("line", 0, waresY, width/2, (h3 + 2) * MAX_WARE_TYPES)
  love.graphics.rectangle("line", width/2, waresY, width/2, (h3 + 2) * MAX_WARE_TYPES)
  if next(player.q) then
    local i = 0
    for item, n in pairs(player.q) do
      local h = waresY + (h3 + 2) * i
      love.graphics.print(item, 2, h)
      love.graphics.print(n, width/2 - 54, h)
      i = i + 1
    end
    for _,b in ipairs(self.playerB) do
      b:draw()
    end
  else
    love.graphics.print("No Wares", 2, waresY)
  end
  if next(self.trader.q) then
    local i = 0
    for item, n in pairs(self.trader.q) do
      local h = waresY + (h3 + 2) * i
      love.graphics.print(item, width/2 + 2, h)
      --print(next(self.prices))
      local price = "Price: "..self.prices[item].."C"
      love.graphics.print(price, width * 0.75 - price:len() * h3/4, h)
      love.graphics.print(n, width - 54, h)
      i = i + 1
    end
    for _,b in ipairs(self.traderB) do
      b:draw()
    end
  else
    love.graphics.print("No Wares", width/2 + 2, waresY)
  end
  --Show Deal
  love.graphics.setFont(self.h2)
  love.graphics.print("Deal", width/2 - h2 - 4, dealY)
  love.graphics.setFont(self.h3)
  love.graphics.rectangle("line", 0, dealT, width/2, (h3 + 2) * MAX_WARE_TYPES)
  love.graphics.rectangle("line", width/2, dealT, width/2, (h3 + 2) * MAX_WARE_TYPES)
  if next(self.deal['player']) then
    local i = 0
    for item, n in pairs(self.deal['player']) do
      if n > 0 then
        local h = dealT + (h3 + 2) * i
        love.graphics.print(item, 2, h)
        local total = nil
        if self.prices[item] then
          total = self.prices[item] * n
        else
          total = medianPrice() * n
        end
        total = total.."C"
        love.graphics.print(total, width/4 - total:len() * h3/4, h)
        love.graphics.print(n, width/2 - 54, h)
        i = i + 1
      end
    end
  end
  if next(self.deal['trader']) then
    local i = 0
    for item, n in pairs(self.deal['trader']) do
      if n > 0 then
        local h = dealT + (h3 + 2) * i
        love.graphics.print(item, width/2 + 2, h)
        local total = (self.prices[item] * n).."C"
        love.graphics.print(total, width * 0.75 - total:len() * h3/4, h)
        love.graphics.print(n, width - 54, h)
        i = i + 1
      end
    end
  end
  --Show Resulting transaction
  love.graphics.setFont(self.h2)
  love.graphics.print("Result:", 0, finalY)
  local fpcStr = (player.credits + self.total).." credits"
  love.graphics.print(fpcStr, width/4 - fpcStr:len() * h2/4, finalY)
  local tpcStr = (self.trader.credits - self.total).." credits"
  love.graphics.print(tpcStr, width * 0.75 - tpcStr:len() * h2/4, finalY)
  --Show Reset/Confirm buttons
  self.reset:draw()
  self.confirm:draw()
  --Show Exit button
  self.exit:draw()
end

function checkButtonClicked (x, y, buttons)
  for _,b in ipairs(buttons) do
    if b:clicked(x, y) then
      local side = b['side']
      local ware = b['ware']
      local q = b['inv'][ware]
      local dlq = Trade.deal[side][ware]
      if not dlq then
        Trade.deal[side][ware] = 0
        dlq = 0
      end
      local nq = q + b['change']
      local ndlq = dlq - b['change']
      if nq >= 0 and ndlq >= 0 then
        b['inv'][ware] = q + b['change']
        Trade.deal[side][ware] = dlq - b['change']
      end
    end
  end
end

function Trade:resetScene ()
  for item,q in pairs(self.deal.player) do
    player.q[item] = player.q[item] + q
  end
  self.deal.player = {}
  for item,q in pairs(self.deal.trader) do
    self.trader.q[item] = self.trader.q[item] + q
  end
  self.deal.trader = {}
end

function hasTooManyItems (trader, deal)
  for ware,n in pairs(deal) do
    if trader.q[ware] and trader.q[ware] + n > 20 then
      return true
    end
  end
  return false
end

function Trade:mousereleased (x, y, button)
  if button == 1 then
    checkButtonClicked(x, y, self.playerB)
    checkButtonClicked(x, y, self.traderB)
    if self.reset:clicked(x, y) then
      self:resetScene()
    elseif self.confirm:clicked(x, y) then
      local body = " does not have enough credits for this deal."
      local modal = Confirm:new(200, 100, "Insufficient credits")
      if player.credits + self.total < 0 then
        modal.body = "Player"..body
        Director:pushModal(modal)
      elseif self.trader.credits - self.total < 0 then
        modal.body = self.trader.name..body
        Director:pushModal(modal)
      elseif player:getNewWareCount(self.deal.trader) > 10 then
        local body = "You can only carry up to 10 kinds of goods in your cargo space."
        Director:pushModal(Confirm:new(200, 100, "Not enough space!", body))
      elseif hasTooManyItems(player, self.deal.trader) then
        local body = "You can only carry up to 20 units of a good in your cargo space."
        Director:pushModal(Confirm:new(200, 100, "Not enough space!", body))
      else
        for item,q in pairs(self.deal.trader) do
          if not player.q[item] then
            player.q[item] = 0
          end
          player.q[item] = player.q[item] + q
        end
        self.deal.trader = {}
        player.credits = player.credits + self.total
        for item,q in pairs(self.deal.player) do
          if not self.trader.q[item] then
            self.trader.q[item] = 0
          end
          self.trader.q[item] = self.trader.q[item] + q
          if not self.prices[item] then
            self.prices[item] = medianPrice()
          end
        end
        self.deal.player = {}
        self.trader.credits = self.trader.credits - self.total
        loadButtons()
      end
    elseif self.exit:clicked(x, y) then
      self:resetScene()
      Director:changeScene(Galaxy)
    end
  end
end

return Trade
