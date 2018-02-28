# Replicates Ruby's STL Struct behavior
class ConStruct
  # The catch is the fact that initialize is a special method that does not
  # return its presumed returned value. Because it is called by Class.new
  # indirectly. Therefore we need to overwrite Class.new method instead
  # Remember the syntax: Class#instance_method Class.class_method
  def self.new(*properties, &block)
    klass = Class.new(Object) do
      @stored_properties = properties

      properties.each do |property|
        attr_accessor property.to_sym
      end

      def initialize(*values)
        values.each_with_index do |val, index|
          send("#{self.class.properties[index]}=", val)
        end
      end

      def self.properties
        @stored_properties
      end
    end
    # Why can't I run this inside the do block above?
    # we get a block as input, (which is converted to a Proc actually)
    # Okay, so basically, to define a method when all we have is a block, we
    # need to "evaluate" the block. (why that cannot be done with a proc.call, idk)
    # The options to eval code are: instance_eval and class_eval.
    # instance_eval, when run, acts on the receiver of the call, or self. Inside
    # the block above when run outside a def block self is the (still
    # annonymous) class we are creating, which is an instance of the class
    # *Class*, therefore, instance_eval runs code in the scope of the Eigenclass
    # (creating therefore class mathods, and not instance_methods). When run
    # inside a def block, the scope is that of the actual calling object, so the
    # instance_eval creates therefore singleton_methods on the object, when the
    # method is invoked. On the other hand, class_eval evaluates the code in the
    # context of the mod itself, which is basically the same as writing usual
    # code inside the class body definition. So it is the way to define
    # instance_methods or class instance variables.
    klass.class_eval(&block) if block_given?
    klass
  end
end
