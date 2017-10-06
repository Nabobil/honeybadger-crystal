require "http"
require "json"
require "./honeybadger/*"

module Honeybadger
  @@global_client = Honeybadger::Client.new(ENV["HONEYBADGER_API_KEY"])

  def self.notify(error, **kargs)
    @@global_client.notify(error, **kargs)
  end
end
