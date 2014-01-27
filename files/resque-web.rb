#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
begin
  require 'vegas'
rescue LoadError
  require 'rubygems'
  require 'vegas'
end
require 'resque/server'
require 'resque_scheduler'
require 'resque_scheduler/server'
require 'yaml'

Vegas::Runner.new(Resque::Server, 'resque-web', {
  :before_run => lambda {|v|
    path = (ENV['RESQUECONFIG'] || v.args.first)
    load path.to_s.strip if path
  }
}) do |runner, opts, app|
  opts.on('-N NAMESPACE', "--namespace NAMESPACE", "set the Redis namespace") {|namespace|
    runner.logger.info "Using Redis namespace '#{namespace}'"
    Resque.redis.namespace = namespace
  }
  opts.on('-r redis-connection', "--redis redis-connection", "set the Redis connection string") {|redis_conf|
    runner.logger.info "Using Redis connection '#{redis_conf}'"
    Resque.redis = redis_conf
  }
end
