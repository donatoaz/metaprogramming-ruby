# Creating attr_accessible to immitate ruby's attr_accessor
class Object
  private

  def attr_accessible(*attrs)
    attrs.each do |attr|
      define_method(attr) do
        instance_variable_get "@#{attr}"
      end
      define_method("#{attr}=") do |val|
        instance_variable_set "@#{attr}", val
      end
    end
  end
end

# testing
class MyClass
  attr_accessible :foo, :bar
end
