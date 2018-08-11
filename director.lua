Director = {scene = nil}

function Director:changeScene(scene)
  self.scene = scene
end

function Director:update(dt)
  if self.scene ~= nil then
    self.scene:update(dt)
  end
end

function Director:draw()
  if self.scene ~= nil then
    self.scene:draw()
  end
end
