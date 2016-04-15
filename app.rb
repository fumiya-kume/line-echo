# Mostly taken from http://qiita.com/masuidrive/items/1042d93740a7a72242a3

require 'sinatra/base'
require 'json'
require 'rest-client'

class App < Sinatra::Base

  # @param [string] 
  def PostLine(message)
    request_content = {
        :to => [u8a142816f293877494cba3dd07f1923f],
        :toChannel => 1383378250, # Fixed  value
        :eventType => "138311608800106203", # Fixed value

        :content => {
            :contentType => 1,
            :toType => 1,
            :text => "Hello World"
        }
    }
    endpoint_uri = 'https://trialbot-api.line.me/v1/events'
    content_json = request_content.to_json

    RestClient.proxy = ENV['FIXIE_URL'] if ENV['FIXIE_URL']
    RestClient.post(endpoint_uri, content_json, {
        'Content-Type' => 'application/json; charset=UTF-8',
        'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
        'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
        'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
    })

  end

  get 'LinePost/' do

    request_content = {
        :to => [u8a142816f293877494cba3dd07f1923f],
        :toChannel => 1383378250, # Fixed  value
        :eventType => "138311608800106203", # Fixed value

        :content => {
            :contentType => 1,
            :toType => 1,
            :text => "Hello World"
        }
    }
    endpoint_uri = 'https://trialbot-api.line.me/v1/events'
    content_json = request_content.to_json

    RestClient.proxy = ENV['FIXIE_URL'] if ENV['FIXIE_URL']
    RestClient.post(endpoint_uri, content_json, {
        'Content-Type' => 'application/json; charset=UTF-8',
        'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
        'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
        'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
    })

    'OK'
  end


  post '/linebot/callback' do
    params = JSON.parse(request.body.read)

    params['result'].each do |msg|
      request_content = {
          :to => [msg['content']['from']],
          :toChannel => 1383378250, # Fixed  value
          :eventType => "138311608800106203", # Fixed value
          #オウム返しする場合

          #[u8a142816f293877494cba3dd07f1923f]

          content: {
              :contentType => 1,
              :toType => 1,
              :text => [msg['content']['from']]
          }
      }

      endpoint_uri = 'https://trialbot-api.line.me/v1/events'
      content_json = request_content.to_json

      RestClient.proxy = ENV['FIXIE_URL'] if ENV['FIXIE_URL']
      RestClient.post(endpoint_uri, content_json, {
          'Content-Type' => 'application/json; charset=UTF-8',
          'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
          'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
          'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
      })
    end

    "OK"
  end

  # post '/linebot/callback' do
  #   params = JSON.parse(request.body.read)
  #
  #   params['result'].each do |msg|
  #     request_content = {
  #         :to => [msg['content']['from']],
  #         :toChannel => 1383378250, # Fixed  value
  #         :eventType => "138311608800106203", # Fixed value
  #         #オウム返しする場合
  #
  #         #[u8a142816f293877494cba3dd07f1923f]
  #
  #         content: {
  #             :contentType => 1,
  #             :toType => 1,
  #             :text => [msg['content']['from']]
  #         }
  #     }
  #
  #     endpoint_uri = 'https://trialbot-api.line.me/v1/events'
  #     content_json = request_content.to_json
  #
  #     RestClient.proxy = ENV['FIXIE_URL'] if ENV['FIXIE_URL']
  #     RestClient.post(endpoint_uri, content_json, {
  #         'Content-Type' => 'application/json; charset=UTF-8',
  #         'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
  #         'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
  #         'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
  #     })
  #   end
  #
  #   "OK"
  # end

end

end
