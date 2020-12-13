require 'nokogiri'
module Lita
  module Handlers
    class Good < Handler
      # insert handler code here
      route(
          /^"(.*)"$/,
          :respond_with_info,
          command: true,
          help: {'"lita translation mission"' => '找到手册上关于lita translation mission的解决办法'}
      )

      def respond_with_info(response)
        n = response.match_data.captures.first

        response.reply("Lita正在查找有关#{n}的信息")
        http_response = http.get(
            "http://101.201.197.54:8080/api.php?action=query&list=search&srsearch=#{URI::encode(n)}&utf8=&format=json"
        )
        # http://localhost:8080/api.php?action=parse&page=lita/translation&format=json
        data = MultiJson.load(http_response.body)
        rep_code = data["query"]['searchinfo']['totalhits']
        rep = data["query"]['search']
        if rep_code > 0
          rep.each_with_index { |item, index|
            response.reply(print_info(item, n, index))
            if index > 2
              break
            end
          }


        else
          response.reply("Lita没有找到有关#{n}的信息")
        end


      end

      def print_info(pair, n, index)

        http_response = http.get(
            "http://101.201.197.54:8080/api.php?action=parse&page=#{URI::encode(pair['title'])}&utf8=&format=json"
        )

        text = MultiJson.load(http_response.body)['parse']['text']['*']
        doc = Nokogiri::HTML(text)



        "#{index + 1}. #{pair['title']}：#{doc.text.gsub("\n","")} http://helpful.wiki.example.com/#{URI::encode(pair['title'])}"
      end

      Lita.register_handler(self)
    end
  end
end
