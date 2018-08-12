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
    if star.name == player['loc'] then
      local x = star.x
      local y = star.y
      love.graphics.setColor(0,255,0)
      love.graphics.circle("fill", x, y, Star.RADIUS)
      local text = "You"
      local tx = nil
      local ty = nil
      local lineTo = {x=nil, y=nil}
      if x > width - text:len() * 9 then
        tx = x - Star.RADIUS - text:len() * 6
        lineTo.x = x - Star.RADIUS
      else
        tx = x + Star.RADIUS
        lineTo.x = tx
      end
      if y < text:len() * 6 then
        ty = y - 6
      else
        ty = y - Star.RADIUS - 12
      end
      lineTo.y = ty + 6
      love.graphics.line(x, y, lineTo.x, lineTo.y)
      love.graphics.print(text, tx, ty)
    end
  end
end

function mouseInStar (x, y, star)
  return distance(x, y, star.x, star.y) < Star.RADIUS
end

function Galaxy:mousemoved (x, y, dx, dy)
  for _,star in ipairs(self.stars) do
    if mouseInStar(x, y, star) then
      star.hover = true
    else
      star.hover = false
    end
  end
end

function Galaxy:mousereleased (x, y, button)
  if button == 1 then
    for _,star in ipairs(self.stars) do
      if mouseInStar(x, y, star) then
        player['loc'] = star.name
      end
    end
  end
end

return Galaxy
