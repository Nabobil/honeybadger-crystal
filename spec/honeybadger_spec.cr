require "json"
require "./spec_helper"

describe Honeybadger do
  describe ".notify" do
    it "just works" do
      Honeybadger.notify(DummyError.new)
    end

    it "works when passing a request" do
      request = HTTP::Request.new(
        method: "POST",
        resource: "/foobar?query=param",
        headers: HTTP::Headers{
          "Host" => "www.example.com",
          "Content-Type" => "application/json"
        },
        body: <<-JSON
        {"key":"value"}
        JSON
      )
      Honeybadger.notify(DummyError.new, request: request)
    end

    it "works when passing a context" do
      Honeybadger.notify(DummyError.new, context: {
        user_id: "124"
      })
    end
  end
end
