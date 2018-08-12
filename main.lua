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
  --name=min price
  goods = {
    Fuel=1,
    Food=1,
    Ore=2,
    Alloys=4,
    Fabric=2,
    Clothing=4,
    Machinery=3,
    Computers=5,
    Gold=6,
    Platinum=7,
    Gems=6,
    Perfume=5,
    Powder=7,
    Phasers=7,
    Drones=8,
    Artifacts=10
  }
  contraband = {'powder'}
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

function love.mousemoved (x, y, dx, dy)
  Director:mousemoved(x, y, dx, dy)
end
