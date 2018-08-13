MAX_WARE_TYPES = 10
MAX_WARE_SUPPLY = 10

Button = require "../button"
Confirm = require "modal"
Director = require "director"
Trader = require "trader"
Trade = require "scenes.trade"
Galaxy = require "scenes.galaxy"

function distance (x1, y1, x2, y2)
  return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

function randomKey (t)
  local keys = {}
  for k,v in pairs(t) do
    table.insert(keys, k)
  end
  local i = rng:random(1, #keys)
  return keys[i]
end

function inTable (t, query)
  local has = {}
  for _,v in ipairs(t) do
    has[v] = true
  end
  return has[query]
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
  contraband = {'Powder'}
  player = Trader:new("Player")
  player.q['Fuel'] = 10
  player['loc'] = "Jav'n"
  Director:changeScene(Galaxy, 13)
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
