require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'English'

ENV['RACK_ENV'] ||= 'test'
RACK_ENV = ENV['RACK_ENV'] ||= ENV['RACK_ENV'] ||= 'test' unless defined?(RACK_ENV)

#PadrinoTasks.use(:database)
#PadrinoTasks.init
PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init

task :version do
  require './lib/version'
  puts Version.current
  exit 0
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:acceptance) do |task|
  task.cucumber_opts = ['features', '--tags \'not @wip and not @local\'', '--format pretty', '--format html -o reports/cucumber.html']
end

if %w[development test].include?(RACK_ENV)

  task :all do
    ['rake spec', 'rake cucumber'].each do |cmd|
      puts "Starting to run #{cmd}..."
      system("export DISPLAY=:99.0 && bundle exec #{cmd}")
      raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
    end
  end

  task :build_server do
    ['rake spec_report', 'rake cucumber_report'].each do |cmd|
      puts "Starting to run #{cmd}..."
      system("export DISPLAY=:99.0 && bundle exec #{cmd}")
      raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
    end
  end

  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:cucumber) do |task|
    Rake::Task['db:migrate'].invoke
    task.cucumber_opts = ['features', '--tags \'not @wip\'']
  end

  Cucumber::Rake::Task.new(:cucumber_report) do |task|
    Rake::Task['db:migrate'].invoke
    task.cucumber_opts = ['features', '--format html -o reports/cucumber.html']
  end

  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    Rake::Task['db:migrate'].invoke
    t.pattern = './spec/**/*_spec.rb'
  end

  RSpec::Core::RakeTask.new(:spec_report) do |t|
    t.pattern = './spec/**/*_spec.rb'
    t.rspec_opts = %w[--format RspecJunitFormatter --out reports/spec/spec.xml]
  end

  task default: [:all]

end
