Ww = love.graphics.getWidth()
Wh = love.graphics.getHeight()

love.load = function()
  analog = require("Manalog")
  firstAnalog = analog:new(100, Wh - 100, 75)
  secondAnalog = analog:new(Ww - 100, Wh - 100, 75)
  firstAnalog:print()
end

love.draw = function()
  firstAnalog:draw()
  secondAnalog:draw()

  --==========================--
  local pr = love.graphics.print

  pr(firstAnalog.data.x, 10, 10)
  pr(firstAnalog.data.y, 10, 30)

  pr(secondAnalog.data.x, 10, 120)
  pr(secondAnalog.data.y, 10, 140)
end

love.update = function()
  firstAnalog:update()
  secondAnalog:update()
end

love.touchmoved = function(id, x, y, dx, dy)
  firstAnalog:touch(id, x, y, dx, dy)
  secondAnalog:touch(id, x, y, dx, dy)
end

love.resize = function()
  Ww = love.graphics.getWidth()
  Wh = love.graphics.getHeight()

  firstAnalog:reconfig({ x = 100, y = Wh - 100 })
  secondAnalog:reconfig({ x = Ww - 100, y = Wh - 100 })
end
