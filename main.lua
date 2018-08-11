Director = require "director"
Trader = require "trader"
Trade = require "scenes.trade"

function love.load()
  width, height = love.graphics.getDimensions()
  player = Trader:new("Player")
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
