require('libs/animate')

function love.load()
   local push = table.insert
   
   love.physics.setMeter(32)
   world = love.physics.newWorld(0, 9.81*32, true)
   
   objects = {}
   
   -- the player
   player = {}
   player.prev_direction = 'none'
   player.speed = 300
   player.body = love.physics.newBody(world, 100, 100, 'dynamic')
   player.body:setMass(100)
   player.shape = love.physics.newRectangleShape(32, 64)
   player.fixture = love.physics.newFixture(player.body, player.shape)
   -- player.fixture:setFriction(0.1)
   player.img  = love.graphics.newImage('assets/player.png')
   player.anim = newAnimation(player.img, 64, 64, 0.1, 1, 3)
   -- for animation flipping based on travel direction
   player.flip = false

   push(objects, player)

   -- the ground
   static = {}
   static.body = love.physics.newBody(world, 0 ,700, 'static')
   static.shape = love.physics.newEdgeShape(0, 0, 2000, 0)
   static.fixture = love.physics.newFixture(static.body, static.shape)
end

-- moving the player around
function move(obj)
  local k = love.keyboard.isDown
  local kdown = 0
  local direction = ''
  
   if k('d') then
      direction = 'd'
      kdown = kdown + 1
      player.anim:setFrameRange(5, 7)      
      player.flip = false
      obj.body:applyForce(500, 0)
   elseif k('a') then
      direction = 'a'
      kdown = kdown + 1
      player.anim:setFrameRange(5, 7)
      -- flip the animation
      player.flip = true
      obj.body:applyForce(-500, 0)
   end
   
   if k('w') then 
      direction = 'w'
      kdown = kdown + 1
      obj.body:applyForce(0, -1000)
   elseif k('s') then
      direction = 's'
      kdown = kdown + 1
      obj.body:applyForce(0, 1000)
   end
   
   -- TODO changing direction causes sliding
   local direction_match = direction == player.prev_direction 
   if kdown > 0 and direction_match then
      player.body:setLinearDamping(0)
   elseif direction_match then
      player.body:setLinearDamping(6)
   else
     player.body:setLinearDamping(15)
   end
   player.prev_direction = direction
   
   set_max_speed(player.body, 300)
end

function set_max_speed(body, speed)
   local x, y = body:getLinearVelocity()
   if x*x + y*y > speed*speed then
      local angle = math.atan2(y,x)
      body:setLinearVelocity(speed * math.cos(angle),
                             speed * math.sin(angle))
   end
end

function love.update(dt)
   mouseX = love.mouse.getX()
   mouseY = love.mouse.getY()
   
   -- for moving objects around, not currently used
   if love.mouse.isDown('l') then
      for i, v in pairs(objects) do
         if v.fixture:testPoint(mouseX, mouseY) then
            focused = v
            break
         else focused = nil
         end
      end
   end
   
   move(player)
   if not love.keyboard.isDown('w', 'a', 's', 'd') then
      player.anim:setFrameRange(1, 3)
   end

   -- update calls
   world:update(dt)
   player.anim:update(dt)
end

-- draw call
function love.draw()
   -- draw the player
   player.anim:draw(player.body:getX() - 32, player.body:getY() - 32, 0, (player.flip and  -1 or 1), 1, 32, 0)
   -- draw the ground
   love.graphics.line(static.body:getWorldPoints(static.shape:getPoints()))
end
