require 'minitest/autorun'
require 'minitest/color'
require_relative '../tasks/task_create_html_dsl'


class TestHTML < MiniTest::Test
  def setup; end

  def test_args_to_tag_parameters_single
    html = HTML.new
    props = html.args_to_tag_parameters(test: 'val1')
    assert_equal ' TEST="val1"', props
  end

  def test_args_to_tag_parameters_multiple
    html = HTML.new
    props = html.args_to_tag_parameters(test: 'val1', test2: 'val2')
    assert_equal ' TEST="val1" TEST2="val2"', props
  end

  def test_args_to_tag_parameters_invalid
    html = HTML.new
    assert_equal '', html.args_to_tag_parameters('teste')
  end

  def test_argument_capture
    html = HTML.new do
      html do
        head do
          title 'Título'
        end
        body do
          h1 'H1 Rocks'
          ul prop1: 'test' do
            li 'content1'
            li 'content2'
          end
          span 'The End'
        end
      end
    end
    # gsub is meant to remove this nasty new-line character at the end of the
    # Heredoc
    expected = <<~HTML.gsub(/\n\z/,'')
      <html><head><title>Título</title></head><body>
          <h1>H1 Rocks</h1>
          <ul PROP1="test">
            <li>content1</li>
            <li>content2</li>
          </ul>
          <span>The End</span></body></html>
    HTML
    assert_equal expected, html.to_s
  end
end
