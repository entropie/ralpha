#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/ralpha"

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = %q[-f d -r lib/ralpha]
  t.skip_bundler = true  
  t.rcov = false
end

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
