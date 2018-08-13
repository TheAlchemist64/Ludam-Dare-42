local GameOver = {}

function GameOver:load()
  self.font = love.graphics.newFont(32)
end
function GameOver:update (dt) end
function GameOver:draw ()
  love.graphics.setFont(self.font)
  local text = "Game Over"
  love.graphics.print(text, width/2 - text:len() * 16 + 64, height/2 - 32)
end

return GameOver
