local Confirm = {}

function Confirm:new (w, h, title, body)
  local o = {width=w,height=h,title=title,body=body, visible=true}
  local label = "OK"
  local x = width/2 - label:len() * 5
  o.ok = Button:new(x, height/2 + h/2 - 20, 28, 20, label)
  o.ok:setStyle{fSize=16, padding={2,2}}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Confirm:draw ()
  if self.visible then
    local x = width/2 - self.width/2
    local y = height/2 - self.height/2
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x, y, self.width, self.height)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", x, y, self.width, self.height)
    local titleX = width/2 - self.title:len() * 4
    love.graphics.print(self.title, titleX, y)
    love.graphics.line(x, y + 18, x + self.width, y + 16)
    love.graphics.printf(self.body, x, y + 18, self.width)
    self.ok:draw()
  end
end

return Confirm
