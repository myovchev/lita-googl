# lita-googl

[![Build Status](https://travis-ci.org/myovchev/lita-googl.png?branch=master)](https://travis-ci.org/myovchev/lita-googl)
[![Coverage Status](https://coveralls.io/repos/myovchev/lita-googl/badge.svg?branch=master)](https://coveralls.io/r/myovchev/lita-googl?branch=master)

**lita-googl** is a handler for [Lita][lita] that shortens URLs
via [URL Shortener API][googl-dev]

## Installation

Add lita-googl to your Lita instance's Gemfile:

``` ruby
gem "lita-googl"
```

## Configuration

Add the configuration lines (listed below) to your application `lita_config.rb`

* `config.handlers.googl.api_key="YOUR_API_KEY"`
    * Get a **Public API access** key from [Google Developer Console][google-console]
    and replace the `YOUR_API_KEY` above.
    * More detailed information about [Google Public API key][google-pauth]

### Secure it

You may "hide" your API key from the application config like this  
`config.handlers.googl.api_key=ENV['GOOGL_API_KEY']` and in your terminal

```shell
$ GOOGL_API_KEY=XXXXXXXX
$ export GOOGL_API_KEY
$ # Ensure it's there
$ echo $GOOGL_API_KEY
XXXXXXXX
```

## Usage

```
22:55 <SecretR> ZaraRobo google http://zaralab.org/
22:55 <ZaraRobo> SecretR http://goo.gl/x5PsTf
```


[lita]: http://lita.io/ "A robot companion for your company's chat room"
[googl-dev]: https://developers.google.com/url-shortener/ "The Google URL Shortener at goo.gl"
[google-pauth]: https://developers.google.com/url-shortener/v1/getting_started#APIKey
[google-console]: https://console.developers.google.com/ "Google Developer Console"
