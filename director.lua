local Director = {scene = nil, modals={}}

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
  if #self.modals > 0 then
    self.modals[1]:draw()
  end
end
--Push modal to list
function Director:pushModal (m)
  local matches = false
  for _,modal in ipairs(self.modals) do
    if m.title == modal.title then
      matches = true
    end
  end
  if not matches then
    table.insert(self.modals, m)
  end
end
--remove modal from list
function Director:removeModal (m)
  table.remove(self.modals, m)
end
--Handle mouse relase/clicks
function Director:mousereleased (x, y, button)
  if #self.modals > 0 then
    if self.modals[1].ok:clicked(x, y) then
      table.remove(self.modals, 1)
    end
  elseif self.scene ~= nil and self.scene.mousereleased then
    self.scene:mousereleased(x, y, button)
  end
end
--Handle mouse movement
function Director:mousemoved (x, y, dx, dy)
  if self.scene ~= nil and self.scene.mousemoved then
    self.scene:mousemoved(x, y, dx, dy)
  end
end

return Director
