Star = require "../star"

local Galaxy = {}

function Galaxy:load (nStars)
  self.stars = {}
  for i=1,nStars do
    local x = rng:random(Star.RADIUS, width - Star.RADIUS)
    local y = rng:random(Star.RADIUS, height - Star.RADIUS - 12)
    local name = "Star "..i
    table.insert(self.stars, Star:new(name, x, y))
  end
end

function Galaxy:update (dt)

end

function Galaxy:draw ()
  for _,star in ipairs(self.stars) do
    star:draw()
  end
end

return Galaxy
