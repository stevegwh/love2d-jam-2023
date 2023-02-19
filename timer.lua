local timer = class('timer')

function timer:initialize(time)
    self.maxCount = time
    self.count = 0
end

function timer:hasFinished()
    return self.count >= self.maxCount
end

function timer:resetTimer()
    self.count = 0
end

function timer:update(dt)
    if not self:hasFinished() then
        self.count = self.count + dt
    end
end

return timer
