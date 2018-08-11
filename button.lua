local Button = {}

function Button:new (x, y, width, height, label)
  local o = {
    x=x,
    y=y,
    width=width,
    height=height,
    label=label,
    style={
      fSize=12,
      padding=0,
      bg=nil,
      fg={255,255,255},
      border={255,255,255}
    },
    _font=love.graphics.newFont()
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Button:setStyle (t)
  for prop,v in pairs(t) do
    self.style[prop] = v
    if prop == "fSize" then
      self._font = love.graphics.newFont(v)
    end
  end
end

function Button:draw ()
  love.graphics.setColor(unpack(self.style.border))
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
  if self.style.bg then
    love.graphics.setColor(unpack(self.style.bg))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
  love.graphics.setColor(unpack(self.style.fg))
  love.graphics.setFont(self._font)
  local padding = self.style.padding
  love.graphics.print(self.label, self.x + padding, self.y + padding)
end

return Button
