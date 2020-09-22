ball = {}
    ball.radius = 25

    ball.position = {}
    ball.position.x = love.graphics.getWidth() / 2
    ball.position.y = love.graphics.getHeight() / 2

    ball.velocity = {}
    ball.velocity.x = 0
    ball.velocity.y = 0

    gravity = 0.98

    ball.applyInitialVelocity = function()
        initialVelocity = {}
        initialVelocity.x = ball.position.x - love.mouse.getX()
        initialVelocity.y = ball.position.y - love.mouse.getY()

        ball.velocity.x = initialVelocity.x / 5
        ball.velocity.y = initialVelocity.y / 5
    end

    ball.applyGravity = function()
        ball.velocity.y = ball.velocity.y + gravity
    end

    ball.move = function()
        ball.position.x = ball.position.x + ball.velocity.x
        ball.position.y = ball.position.y + ball.velocity.y
    end

    ball.bounce = function()
        if ball.position.x <= ball.radius then
            ball.position.x = ball.radius
            ball.velocity.x = ball.velocity.x * -0.75
        end

        if ball.position.x >= love.graphics.getWidth() - ball.radius then
            ball.position.x = love.graphics.getWidth() - ball.radius
            ball.velocity.x = ball.velocity.x * -0.75
        end

        if ball.position.y <= ball.radius then
            ball.position.y = ball.radius
            ball.velocity.y = ball.velocity.y * -0.75
        end

        if ball.position.y >= love.graphics.getHeight() - ball.radius then
            ball.position.y = love.graphics.getHeight() - ball.radius
            ball.velocity.y = ball.velocity.y * -0.75
            ball.velocity.x = ball.velocity.x * 0.99;
        end
    end

started = false
dragging = false

function checkStart()
    dx = ball.position.x - love.mouse.getX();
    dy = ball.position.y - love.mouse.getY();
    distance = math.sqrt(dx * dx + dy * dy);

    if distance <= ball.radius then
        return true
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 and started == false then
        if checkStart() == true then
            started = true
            dragging = true
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 and dragging == true then
        dragging = false
        ball.applyInitialVelocity()
    end
 end

function love.load()
    love.graphics.setColor(1, 1, 1)
end

function love.update()
    if started == true and dragging == false then
        ball.applyGravity()
        ball.move()
        ball.bounce()
    end
end

function love.draw()
    if dragging == true then
        love.graphics.line(ball.position.x, ball.position.y, love.mouse.getX(), love.mouse.getY())
    end

    love.graphics.circle("fill", ball.position.x, ball.position.y, ball.radius)
end