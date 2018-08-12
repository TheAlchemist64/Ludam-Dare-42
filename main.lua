MAX_WARE_TYPES = 10
MAX_WARE_SUPPLY = 10

Director = require "director"
Trader = require "trader"
--Trade = require "scenes.trade"
Galaxy = require "scenes.galaxy"

function distance (x1, y1, x2, y2)
  return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

function love.load()
  width, height = love.graphics.getDimensions()
  rng = love.math.newRandomGenerator()
  rng:setSeed(os.time())
  player = Trader:new("Player")
  player.q['fuel'] = 10
  player['loc'] = 'Star 1'
  Director:changeScene(Galaxy, 10)
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
