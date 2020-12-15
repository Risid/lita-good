require 'digest/md5'

module Lita
  module Handlers
    class Translator < Handler
      # insert handler code here
      route(
        /^(翻译(?!是什么).*)/,
        :respond_with_translation,
        command: true,
        help:{'puma是什么意思' => '美洲狮'}
      )

      def respond_with_translation(response)
        n = response.match_data.captures.first.encode('utf-8')
        response.reply("Lita正在#{n}的中文...")
        salt = "1435660288"
        appid = "20201214000647087"
        secCode = "P4Xaa4qbJkFQ6L3Bmrk_"
        sign = Digest::MD5.hexdigest("#{appid}#{n}#{salt}#{secCode}")
        query = "http://api.fanyi.baidu.com/api/trans/vip/translate?q=#{n}&from=auto&to=zh&appid=#{appid}&salt=#{salt}&sign=#{sign}"
        uri = URI.parse(URI.escape(query))
        http_response = http.get(uri)
        # print(query)
        data = MultiJson.load(http_response.body)
        response.reply("#{n}的中文翻译是#{data["trans_result"][0]["dst"]}")
      end 
      Lita.register_handler(self)
    end
  end
end
