require 'googl'

module Lita
  module Handlers

    class GooglError < StandardError; end
    #class RequestError < GooglError; end
    #class UnknownAPIError < GooglError; end

    class Googl < Handler
      config :username, type: String, required: true
      config :password, type: String, required: true

      route %r{^googl\s+(:?expand)?\s*(.\S+)$}i, :googl, command: true, help: {
        'googl' => 'Shorten original or expand shortened URL.'
      }

      def googl(response)
        expand = response.matches[0][0] == 'expand' || false
        url = response.matches[0][1]
        raise GooglError if url.nil?

        username = Lita.config.handlers.googl.username
        password = Lita.config.handlers.googl.password
        log.debug("Googl Username: #{username}")
        log.debug("Googl Input URL -  #{url}")

        log.debug("Authorizing")
        client = ::Googl.client(username, password)

        if expand
          result = ::Googl.expand(url)
          return response.reply(
            "#{response.user.mention_name} #{result.long_url}"
          )
        end

        result = client.shorten(url)
        response.reply("#{response.user.mention_name} #{result.short_url}")
      end
    end

    Lita.register_handler(Googl)
  end
end
