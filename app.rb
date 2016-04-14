# Mostly taken from http://qiita.com/masuidrive/items/1042d93740a7a72242a3

require 'sinatra/base'
require 'json'
require 'rest-client'

class App < Sinatra::Base
  post '/linebot/callback' do
    params = JSON.parse(request.body.read)

    params['result'].each do |msg|
      request_content = {
          :to => [msg['content']['from']],
          :toChannel => 1383378250, # Fixed  value
          :eventType => "138311608800106203", # Fixed value
          #オウム返しする場合


          # :content => msg['content']

          # :content => {
          #     :location => null,
          #     :id => "325708",
          #     :contentType => 1,
          #     :from => "uff2aec188e58752ee1fb0f9507c6529a",
          #     :createdTime => 1332394961610,
          #     :to => ["u0a556cffd4da0dd89c94fb36e36e1cdc"],
          #     :toType => 1,
          #     :contentMetadata => null,
          #     :text => "Hello, BOT API Server!"
          # }

          content: {contentType: 1, toType: 1, text: "Hello"}
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
end
