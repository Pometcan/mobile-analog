local Analog = {tch={},data={x=0,y=0,a=0}}
Analog.__index = Analog

Analog.__call = function ()
  Analog:print()
end

function Analog:print()
  print("{ x = "..self.x..", y = "..self.y.." }\n{ data_x = "..self.data.x..", data_y = "..self.data.y..", data_angle = "..self.data.a.." }")
end

function Analog:touch(id,x,y,dx,dy)
  if circleCollisions(self,{x=love.mouse.getX(),y=love.mouse.getY(),r=1}) then
    self.tch = {id=id or 0,x=love.mouse.getX() or 0,y=love.mouse.getY or 0,dx=dx or 0,dy=dy or 0}
  else
    self.tch.x = self.x
    self.tch.y = self.y
  end
end

function Analog:new(x,y,r)
  local al = {
    x = x,
    y = y,
    r = r,
    tch = {
      id = 0,
      x = 0,
      y = 0,
      dx = 0,
      dy = 0,
    },
    data = {
      x = 0,
      y = 0,
      a = 0,
      pa = 0,
      px = 0,
      py = 0,
    },
  }
  
  setmetatable(al,Analog)
  return al
end

function Analog:draw()
  love.graphics.circle("line",self.x,self.y,self.r)
  love.graphics.circle("line",self.tch.x or self.x,self.tch.y or self.y,self.r/3)
end

function Analog:update()
  if circleCollisions(self,{x=love.mouse.getX(),y=love.mouse.getY(),r=1}) then
    self.tch = {id=0,x=love.mouse.getX() or 0,y=love.mouse.getY() or 0,dx=dx or 0,dy=dy or 0}
  else
    self.tch.x = self.x
    self.tch.y = self.y
  end
  self.data.x = (self.tch.x-self.x) or 0
  self.data.y = (self.tch.y-self.y) or 0
  self.data.a = math.atan2(self.tch.y-self.y,self.tch.x-self.x) or 0
  self.data.pa = math.sqrt(self.data.x^2+self.data.y^2) or 0
  self.data.px = math.sqrt(self.data.x) or 0
  self.data.py = math.sqrt((self.tch.y^2)+(self.y^2)) or 0
end

function Analog:reconfig(stuff)
  self.x = stuff.x or self.x
  self.y = stuff.y or self.y
  self.r = stuff.r or self.r
end

function circleCollisions(circleA, circleB)
  local dist = (circleA.x - circleB.x)^2 + (circleA.y - circleB.y)^2
  return dist <= (circleA.r + circleB.r)^2
end

return Analog
