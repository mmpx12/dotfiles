# -*- mode: ruby -*- vim:set ft=ruby:

# courtesy of tpope (http://github.com/tpope/tpope/blob/master/.pryrc)

ENV['HOME'] ||= ENV['USERPROFILE'] || File.dirname(__FILE__)

Pry.editor = ENV['VISUAL']
Pry.config.history_file = File.expand_path('~/.cache/history.rb')
begin
  if defined?(Bundler)
    FileUtils.mkdir_p('.bundle')
    Pry.config.history_file_= Bundler.root.join('.bundle/history.rb')
  end
rescue
end
Pry.config.history_load = true
Pry.config.history_save = true

# gem install pry-theme
# Pry.config.theme = "pry-classic-256"

Pry.config.print = proc do |output, value|
  output.puts "  \001\e[1;38;5;2m\002❮\001\e[0m\002 #{value.inspect}"
end
Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "  \001\e[1;38;5;1m\002❮\001\e[0m\002 #{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}"
end

Pry.prompt = Pry::Prompt.new(
    :custom,
    'Custom minimalistic emoji prompt.',
    [
      proc do |target_self, nest_level, pry|
        "\001\e[01;38;5;1m\002\ue791 \001\e[01;38;5;2m\002#{"❯" * (nest_level + 1)}\001\e[0m\002 "
      end,
      proc do |target_self, nest_level, pry|
        "  #{' ' * nest_level}\001\e[1;38;5;2m\002\ue621\001\e[0m\002 "
      end
    ]
)

$LOAD_PATH.unshift(File.expand_path('~/.ruby/lib'), File.expand_path('~/.ruby'))
$LOAD_PATH.uniq!

%w(pry-editline).each do |lib|
  begin
    require lib
  rescue LoadError
  end
end
