MAX_WARE_TYPES = 10
MAX_WARE_SUPPLY = 10

Director = require "director"
Trader = require "trader"
Trade = require "scenes.trade"

function love.load()
  width, height = love.graphics.getDimensions()
  player = Trader:new("Player")
  player.q['fuel'] = 10
  --Test Trader
  zuzu = Trader:new("Zuzu")
  zuzu.q['zufa'] = 10
  Director:changeScene(Trade, "Placeholder", zuzu)
end

function love.update(dt)
  Director:update(dt)
end

function love.draw()
  Director:draw()
end

function love.mousereleased(x, y, button)
  Director:mousereleased(x, y, button)
end
