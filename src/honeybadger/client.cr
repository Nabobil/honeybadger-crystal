module Honeybadger
  class Client
    private getter :api_token

    def initialize(@api_token : String)
    end

    def notify(error, **kargs)
      body = generate_payload(error, **kargs).to_json
      post "/v1/notices", body
    end

    private def post(path, body)
      url = "https://api.honeybadger.io#{path}"
      headers = HTTP::Headers{
        "X-API-Key" => api_token,
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      response = HTTP::Client.post url, headers, body
      case response.status_code
      when 201
        JSON.parse(response.body)
      else
        raise "Honeybadger API client failed"
      end
    end

    private def generate_payload(error, **kargs)
      {
        notifier: {
          name: "Honeybadger Notifier",
          url: "https://github.com/Nabobil/honeybadger-crystal",
          version: VERSION
        },
        error: serialize(error),
        request: serialize_request(**kargs),
        server: {
          project_root: {
            path: Dir.current
          },
          environment_name: environment_name,
          hostname: System.hostname
        }
      }
    end

    private def serialize_request(request : HTTP::Request? = nil, context = nil)
      return { context: context } unless request
      params = {} of String => String
      request.query_params.each do |key, value|
        params[key] = value
      end
      {
        context: context,
        params: params,
        url: "http://#{request.host_with_port}#{request.resource}"
      }
    end

    private def serialize(error)
      {
        class: error.class.name,
        message: error.message,
        tags: [] of String,
        backtrace: error.backtrace?.try &.map do |line|
          if match = line.match(/(0x[[:xdigit:]]+): (.*) at (.*)/)
            method = match[2]
            if match2 = match[3].match(/(.*) (\d+):\d+/)
              file = match2[1]
              number = match2[2]
              {
                method: method,
                file: file,
                number: number,
              }
            end
          end
        end.compact
      }
    end

    private def environment_name
      ENV["HONEYBADGER_ENV"]? || ENV["KEMAL_ENV"]? || ENV["CRYSTAL_ENV"]? || "development"
    end
  end
end