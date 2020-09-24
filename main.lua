require "classes/ball"

ball = Ball:new()

platforms = {}
platformP1 = {}
platformP2 = {}

shotStarted = false
shotEnded = false
dragging = false

function drawDrag(initialClick)
    if initialClick.x then
        love.graphics.line(initialClick.x,
                        initialClick.y,
                        love.mouse.getX(),
                        love.mouse.getY())
    end
end

function checkShotStarted()
    dx = ball.position.x - love.mouse.getX();
    dy = ball.position.y - love.mouse.getY();
    distance = math.sqrt(dx * dx + dy * dy);

    if distance <= ball.radius then
        shotStarted = true
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 or istouch == true then
        if shotEnded == false then
            dragging = true
            checkShotStarted()
            if shotStarted == false then
                platformP1.x = love.mouse.getX()
                platformP1.y = love.mouse.getY()
            end
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 or istouch == true then
        if shotStarted == true and shotEnded == false then
            dragging = false
            shotEnded = true
            ball:shoot()
        elseif shotStarted == false then
            platformP2.x = love.mouse.getX()
            platformP2.y = love.mouse.getY()
            finalPlatform = {}
            finalPlatform.p1 = platformP1
            finalPlatform.p2 = platformP2
            table.insert(platforms, finalPlatform)
            platformP1 = {}
            platformP2 = {}
        end
    end
 end

function love.load()
    love.graphics.setColor(1, 1, 1)
end

function love.update()
    if shotStarted == true and dragging == false then
        ball:applyGravity()
        ball:move()
        ball:bounce()
    end
end

function love.draw()
    if dragging == true then
        if shotStarted == true then
            drawDrag(ball.position)
        else
            drawDrag(platformP1)
        end
    end

    love.graphics.circle("fill",
                         ball.position.x,
                         ball.position.y,
                         ball.radius)

    for i, platform in ipairs(platforms) do
        love.graphics.line(platform.p1.x,
                           platform.p1.y,
                           platform.p2.x,
                           platform.p2.y)
    end
end

