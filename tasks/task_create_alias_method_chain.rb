# Task: create alias_method_chain
class Module
  def alias_method_chain(orig, extra)
    alias_method "#{orig}_without_#{extra}".to_sym, orig
    alias_method orig, "#{orig}_with_#{extra}".to_sym

    # Not sure if we need to "re"-define orig so that it calls the body of with
    # extra and then calls the original function... I don't think this is what
    # was specified.

    # not sure if this is really necessary, after all, if the user wanted to
    # alias the method, why would anyone call it with its original name?
    private "#{orig}_with_#{extra}".to_sym
  end

  private :alias_method_chain
end

# Original implementation of MyClass
class MyClass
  def foo
    'Original Myclass#Foo'
  end
end

# Changed implementation
class MyClass
  def foo_with_extra
    'This is foo with extra'
  end

  alias_method_chain :foo, :extra
end
