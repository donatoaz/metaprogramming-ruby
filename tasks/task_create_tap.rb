# Re-implementing tap method
class Object
  def my_tap(&block)
    block.call(self) if block_given?
    self
    # we could have used yield, in such case, we do not need to specify the
    # input parameter block, because it is implicit. but, for the sake of
    # explicitness I prefer to maintain this structure above.
    # def my_tap
    #   yield(self) if block_given?
    #   self
    # end
  end

  def tap2(&block)
    self.instance_eval(&block) if block_given?
    self
  end
end

# sample class
class Klass
  def initialize
    @var1 = 10
    @var2 = 100
  end

  def foo
    # transform instance variable
    @var1 += 1
    self
  end

  private

  def bar
    "Private"
  end
end
