local Star = {RADIUS=8}

function Star:new (name, x, y)
  local o = {name=name, x=x, y=y,hover=false}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Star:draw ()
  if self.hover then
    love.graphics.setColor(255,255,0)
  else
    love.graphics.setColor(255,255,255)
  end
  love.graphics.circle("fill", self.x, self.y, Star.RADIUS)
  local nx = self.x - Star.RADIUS - self.name:len() * 2
  love.graphics.setColor(255,255,255)
  love.graphics.print(self.name, nx, self.y + Star.RADIUS)
end

return Star
