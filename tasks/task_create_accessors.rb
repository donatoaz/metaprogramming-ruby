local_var = %i[foo bar baz]

# We are given an array of symbols (local_var). For each value in the array, we
# want to create a method with that value and the method must return the value
# of instance variable with the same name. Basically, we want this result:
#    local_var.each { |name| attr_reader :name }
MyClass = Class.new do
  local_var.each do |name|
    define_method(name) do
      instance_variable_set("@#{name}", name.to_s)
      name
    end
  end
end

# same result as above, but there are subtle differences:
# In other class, the methos created upon initialization are added as singleton
# methods on the objects themselves, therefore, calling
# OtherClass.instance_methods will yield a different result than
# MyClass.instance_methods
class OtherClass
  def initialize(meths)
    meths.each do |meth|
      define_singleton_method(meth) do
        instance_variable_set "@#{meth}", meth.to_s
        meth
      end
    end
  end
end
