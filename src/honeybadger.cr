require "http"
require "json"
require "./honeybadger/*"

module Honeybadger
  @@global_client = Honeybadger::Client.new(ENV["HONEYBADGER_TOKEN"])

  def self.notify(error, **kargs)
    @@global_client.notify(error, **kargs)
  end
end
