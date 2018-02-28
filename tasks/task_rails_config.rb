# Knock-off of Rail's application.rb configure method
module TestApp
  Application = Class.new do
    @config = Hash.new
    define_singleton_method :configure do |&block|
      self.instance_eval(&block) if block
    end

    define_singleton_method :conf do |key|
      config[key]
    end

    define_singleton_method :config do
      @config
    end
  end
end
