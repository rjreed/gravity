
require('libs/animate')

function love.load()
   local push = table.insert
   
   love.physics.setMeter(32)
   world = love.physics.newWorld(0, 9.81*32, true)
   
   objects = {}

   player = {}
   player.body = love.physics.newBody(world, 100, 100, 'dynamic')
   player.body:setMass(10)
   player.shape = love.physics.newRectangleShape(32, 64)
   player.fixture = love.physics.newFixture(player.body, player.shape)
   player.img  = love.graphics.newImage('assets/player.png')
   player.anim = newAnimation(player.img, 64, 64, 0.1, 1, 3)
   player.flip = false

   push(objects, player)

   static = {}
   static.body = love.physics.newBody(world, 0 ,700, 'static')
   static.shape = love.physics.newEdgeShape(0, 0, 1000, 0)
   static.fixture = love.physics.newFixture(static.body, static.shape)
end

function move(obj)
   if love.keyboard.isDown('d') then
      player.anim:setFrameRange(5, 7)      
      player.flip = false
      obj.body:applyForce(1000, 0)
   elseif love.keyboard.isDown('a') then
      player.anim:setFrameRange(5, 7)      
      player.flip = true
      obj.body:applyForce(-1000, 0)
   end
   if love.keyboard.isDown('w') then
      obj.body:applyForce(0, -1000)
   elseif love.keyboard.isDown('s') then
      obj.body:applyForce(0, 1000)
   end
end

function love.update(dt)
   
   mouseX = love.mouse.getX()
   mouseY = love.mouse.getY()
   
   if love.mouse.isDown('l') then
      for i, v in pairs(objects) do
         if v.fixture:testPoint(mouseX, mouseY) then
            focused = v
            break
         else focused = nil
         end
      end
   end
   player.anim:setFrameRange(1,3)
   if love.keyboard.isDown('w', 'a', 's', 'd') then
      move(player)
   end

   world:update(dt)
   player.anim:update(dt)
end

function love.draw()
   player.anim:draw(player.body:getX() - 32, player.body:getY() - 32, 0, player.flip and  -1 or 1, 1, 32, 0) 
   love.graphics.line(static.body:getWorldPoints(static.shape:getPoints()))
end
