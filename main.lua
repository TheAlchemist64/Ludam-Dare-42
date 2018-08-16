MAX_WARE_TYPES = 10
MAX_WARE_SUPPLY = 10
STARTING_MONEY = 20
TRADER_DEFAULT_MONEY = 120
GOAL = 120
TIME_LIMIT = 35

Button = require "../button"
Confirm = require "modal"
Director = require "director"
Trader = require "trader"
Intro = require "scenes.intro"
Trade = require "scenes.trade"
Star = require "star"
Galaxy = require "scenes.galaxy"
GameOver = require "scenes.gameover"
Victory = require "scenes.victory"

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

function calcPrice (good, q)
  return goods[good] + (MAX_WARE_SUPPLY + 1) - q
end

function highestPrice ()
  return goods['Artifacts'] + MAX_WARE_SUPPLY + 1
end

function medianPrice ()
  return MAX_WARE_SUPPLY/2 + 1 --median price of fuel
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
    Alloys=3,
    Fabric=2,
    Clothing=3,
    Machinery=2,
    Computers=3,
    Gold=4,
    Platinum=5,
    Gems=4,
    Perfume=4,
    Powder=6,
    Phasers=6,
    Drones=7,
    Artifacts=9
  }
  contraband = {'Powder'}
  player = Trader:new("Player")
  player.credits = STARTING_MONEY
  player.q['Fuel'] = 10
  --For testing UI
  --player.q['Powder'] = 20--
  player['loc'] = "Jav'n"
  day = 1
  Galaxy:generate(13)
  Director:changeScene(Intro)
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
