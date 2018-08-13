local Victory = {}

function Victory:load()
  self.font = love.graphics.newFont(32)
end
function Victory:update (dt) end
function Victory:draw ()
  love.graphics.setFont(self.font)
  local text = "You Win!"
  love.graphics.print(text, width/2 - text:len() * 16 + 64, height/2 - 32)
end

return Victory
