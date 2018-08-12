local Director = {scene = nil}

--Change current scene
function Director:changeScene(scene, ...)
  self.scene = scene
  scene:load(...)
end
--Update current scene
function Director:update(dt)
  if self.scene ~= nil then
    self.scene:update(dt)
  end
end
--Draw current scene
function Director:draw()
  if self.scene ~= nil then
    self.scene:draw()
  end
end
--Handle mouse relase/clicks
function Director:mousereleased (x, y, button)
  if self.scene ~= nil then
    self.scene:mousereleased(x, y, button)
  end
end

return Director
