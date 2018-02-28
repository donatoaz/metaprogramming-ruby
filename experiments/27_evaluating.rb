# instance_eval and instance_exec can, obviously access private methods,
# afterall, they are evaluated under the scope of the instance itself.
class Klass
  THIS_IS_A_CONSTANT = 100
  @@class_var = 50

  def initialize
    @instance_var = 10
  end

  def public_meth
    "public meth, under #{self}"
  end

  def private_meth
    "private meth, under #{self}"
  end

  def meth_with_arg(arg = 0)
    arg + @instance_var
  end

  private :private_meth
end

a = Klass.new
p a.inspect
p a.public_meth

# this will not run:
# a.private_meth

# but this runs
p(a.instance_eval { private_meth })
p a.inspect
# instance eval, simply executes the block given on the scope of the calling
# object, by seting self to obj during execution. It passes obj as the only arg,
# when instance_eval is given a block.

# instance_exec differs in that we can pass parameters as block arguments to the
# block given
a.instance_exec(5) { |x| puts(@instance_var + x) }

# I didn't really get this "except when" part of the docs:
# Evaluates the string or block in the context of mod, except that when a block
# is given, constant/class variable lookup is not affected. This can be used to
# add methods to a class. module_eval returns the result of evaluating its
# argument. The optional filename and lineno parameters set the text for error
# messages.

# giving a block:
Klass.class_eval do
  def new_method
    "I can temper with instance var: #{@instance_var} and constant: #{Klass::THIS_IS_A_CONSTANT} but not with class variable @@class_var."
  end
end

p a.new_method

Klass.class_eval %q[def another_method; "Can I also temper with #{@instance_var} and #{Klass::THIS_IS_A_CONSTANT}"; end]

p a.another_method

# The way to get at class instance variables is via Module#class_variable_get
# :symbol
p Klass.class_variable_get :@@class_var
