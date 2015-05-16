require 'googl'

module Lita
  module Handlers

    class GooglError < StandardError; end
    #class RequestError < GooglError; end
    #class UnknownAPIError < GooglError; end

    class Googl < Handler
      config :api_key, type: String, required: true
      config :ip, required: false, default: nil

      route %r{^googl\s+(:?expand)?\s*(.\S+)$}i, :googl, command: true, help: {
        'googl' => 'Shorten original or expand shortened URL.'
      }

      def googl(response)
        expand = response.matches[0][0] == 'expand' || false
        url = response.matches[0][1]
        raise GooglError if url.nil?

        api_key = Lita.config.handlers.googl.api_key
        ip = Lita.config.handlers.googl.ip
        log.debug("Googl IP: #{ip}")
        log.debug("Googl Input URL -  #{url}")

        if expand
          result = ::Googl.expand(url)
          return response.reply(
            "#{response.user.mention_name} #{result.long_url}"
          )
        end

        result = ::Googl.shorten(url, ip, api_key)
        response.reply("#{response.user.mention_name} #{result.short_url}")
      end
    end

    Lita.register_handler(Googl)
  end
end
