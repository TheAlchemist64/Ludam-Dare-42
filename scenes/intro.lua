local Intro = {}

function Intro:load()
  self.font = love.graphics.newFont(16)
  local text = [[  You owe Sinex %d credits, and he's tired of waiting.
  You have five weeks to get the credits before his goons find you and throw you out of an airlock. Warping to another star takes a day. You know the markets in the seedy part of the galaxy like the back of your hand. Should be easy, right?

  Click stars on the map to travel to that destination. Traveling consumes 1 fuel, and you lose the game if you run out of fuel.
  Click Trade to start bartering with the merchant at the star where you are stationed.
  On the trade screen, press the '+' button next to a good to add a unit of it to the deal, and '-' to subtract a unit from the deal.
  You ship is only big enough to carry ten kinds of wares, and 20 units of each ware.
  There are two stars where you can trade contraband ("Powder"). Merchants on other stars will not trade with you if you have contraband in your inventory.
  Every week, Merchants restock with new goods, and fill their wallet with credits if they are low.
  Prices fluctuate based on supply, so make sure to watch for good deals.
  Good luck!
  ]]
  self.text = string.format(text, GOAL)
  local label = "Go!"
  self.go = Button:new(width/2 - label:len() * 16, height - 78, label:len() * 16 + 8, 36, label)
  self.go:setStyle{fSize=32}
end
function Intro:update (dt) end
function Intro:draw ()
  love.graphics.setFont(self.font)
  love.graphics.setColor(255,255,255)
  love.graphics.printf(self.text, 0, 0, width)
  self.go:draw()
end

function Intro:mousereleased (x, y, button)
  if button == 1 then
    if self.go:clicked(x, y) then
      Director:changeScene(Galaxy)
    end
  end
end

return Intro
