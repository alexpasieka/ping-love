Ball = {
    radius = 25,

    position = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2
    },

    velocity = {
        x = 0,
        y = 0
    },

    gravity = 0.98
}

function Ball:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Ball:shoot()
    initialVelocity = {
        x = self.position.x - love.mouse.getX(),
        y = self.position.y - love.mouse.getY()
    }

    self.velocity.x = initialVelocity.x / 5
    self.velocity.y = initialVelocity.y / 5
end

function Ball:applyGravity()
    self.velocity.y = self.velocity.y + self.gravity
end

function Ball:move()
    self.position.x = self.position.x + self.velocity.x
    self.position.y = self.position.y + self.velocity.y
end

function Ball:bounce()
    if self.position.x <= self.radius then
        self.position.x = self.radius
        self.velocity.x = self.velocity.x * -0.75
    end

    if self.position.x >= love.graphics.getWidth() - self.radius then
        self.position.x = love.graphics.getWidth() - self.radius
        self.velocity.x = self.velocity.x * -0.75
    end

    if self.position.y <= self.radius then
        self.position.y = self.radius
        self.velocity.y = self.velocity.y * -0.75
    end

    if self.position.y >= love.graphics.getHeight() - self.radius then
        self.position.y = love.graphics.getHeight() - self.radius
        self.velocity.y = self.velocity.y * -0.75
        self.velocity.x = self.velocity.x * 0.99;
    end
end