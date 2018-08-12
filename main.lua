Director = require "director"
Trader = require "trader"
Trade = require "scenes.trade"

MAX_WARE_TYPES = 10

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
