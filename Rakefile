require "bundler/gem_tasks"
require "rake/testtask"
require 'rake/extensiontask'

Rake::ExtensionTask.new("jch") do |ext|
  ext.ext_dir = "ext/jch"
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb', 'test/**/*_bench.rb']
end

task default: %w(compile test)
