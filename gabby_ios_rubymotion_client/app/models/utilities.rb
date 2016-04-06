class Fixnum
   def waitSecondsAnd(&block)
     @t = SimpleTimer.new
     @t.startTimer self, &block
   end
end

class Float
   def waitSecondsAnd(&block)
     @t = SimpleTimer.new
     @t.startTimer self, &block
   end
end

class SimpleTimer
  attr_accessor :fired
  def initialize
    @fired = false
  end

  def startTimer(delay, &block)
    @block = block
    @timer = NSTimer.scheduledTimerWithTimeInterval(delay, target:self, selector:'fire', userInfo:nil, repeats:false)
  end
  def fire
    $fired = true
    @block.call
  end
end
