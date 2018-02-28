require 'htmlbeautifier'

# This is a knock-off of Arbre
# [activeadmin/arbre](https://github.com/activeadmin/arbre)
class HTML
  def initialize(&block)
    @_html = ''
    self.instance_eval(&block) if block_given?
  end

  def to_s
    HtmlBeautifier.beautify(@_html, indent: '  ')
  end

  def args_to_tag_parameters(*args)
    args = args.first
    if args.is_a? Hash
      ' ' + args.map { |key, val| %Q(#{key.upcase}="#{val}") }.join(' ')
    else
      ''
    end
  end

  def args_to_content(*args)
    args.first.is_a?(Hash) ? '' : args.first
  end
  
  def method_missing(tag, *args, &block)
    if block_given?
      @_html << "<#{tag}#{args_to_tag_parameters(args.first)}>"
      self.instance_eval(&block) if block_given?
    else
      @_html << "<#{tag}#{args_to_tag_parameters(args.first)}>"
      @_html << "#{args_to_content(args.first)}"
    end
    @_html << "</#{tag}>"
  end
end
