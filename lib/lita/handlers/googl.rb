require 'googl'

module Lita
  module Handlers

    class GooglError < StandardError; end
    #class RequestError < GooglError; end
    #class UnknownAPIError < GooglError; end

    class Googl < Handler
      config :api_key, type: String, required: true

      route %r{^googl\s+(.\S+)$}i, :googl, command: true, help: {
        'googl' => 'Shorten original or expand shortened URL.'
      }

      def googl(response)
        url = response.matches[0][0]
        raise GooglError if url.nil?

        api_key = Lita.config.handlers.googl.api_key
        log.debug("Googl Input URL -  #{url}")

        result = ::Googl.shorten(url, nil, api_key)
        response.reply("#{response.user.mention_name}: #{result.short_url}")
      end
    end

    Lita.register_handler(Googl)
  end
end
