Director = require "director"
Trade = require "scenes.trade"

function love.load()
  width, height = love.graphics.getDimensions()
  Director:changeScene(Trade, "Placeholder")
end

function love.update(dt)
  Director:update(dt)
end

function love.draw()
  Director:draw()
end
