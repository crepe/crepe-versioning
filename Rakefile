require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = ['--color', '--format progress', '--order rand']
  t.ruby_opts = ['-W2']
end

require 'cane/rake_task'
Cane::RakeTask.new :quality

task default: [:spec, :quality]

task :loc do
  print '  lib   '
  puts `zsh -c "grep -vE '^ *#|^$' lib/**/*.rb | wc -l"`.strip
  print '  spec  '
  puts `zsh -c "grep -vE '^ *#|^$' spec/**/*.rb | wc -l"`.strip
end

require 'yard'
YARD::Rake::YardocTask.new :doc do |t|
  # t.options = ['--hide-void-return']
  t.files = %w[lib/**/*.rb]
end
