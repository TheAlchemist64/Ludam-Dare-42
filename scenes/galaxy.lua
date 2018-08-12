Star = require "../star"

local Galaxy = {}

function Galaxy:load (nStars)
  self.stars = {}
  for i=1,nStars do
    local name = "Star "..i
    local x = rng:random(name:len() * 2, width - Star.RADIUS)
    local y = rng:random(Star.RADIUS, height - Star.RADIUS - 12)
    local valid = true
    for _,star in ipairs(self.stars) do
      if distance(x, y, star.x, star.y) < math.max(name:len() * 2, 32) then
        valid = false
      end
    end
    if valid then table.insert(self.stars, Star:new(name, x, y)) end
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
