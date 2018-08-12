local Star = {RADIUS=8}

function Star:new (name, x, y)
  local o = {name=name, x=x, y=y}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Star:draw ()
  love.graphics.setColor(255,255,255)
  love.graphics.circle("fill", self.x, self.y, Star.RADIUS)
end

return Star
