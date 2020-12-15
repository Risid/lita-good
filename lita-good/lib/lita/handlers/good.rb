require 'nokogiri'
module Lita
  module Handlers
    class Good < Handler
      # insert handler code here
      route(
          /^"(.*)"$/,
          :respond_with_info,
          command: true,
          help: {'"lita translation"' => '找到手册上关于lita translation的解决办法'}
      )

      def respond_with_info(response)
        n = response.match_data.captures.first

        response.reply "Lita正在查找有关#{n}的信息"
        response.reply search_info(n)

      end

      def search_info(n)

        http_response = http.get(
            "https://wiki.risid.com/api.php?action=query&list=search&srsearch=#{URI::encode(n)}&utf8=&format=json"
        )

        data = MultiJson.load(http_response.body)
        rep_code = data["query"]['searchinfo']['totalhits']
        rep = data["query"]['search']
        if rep_code > 0
          good_print = ""
          rep.each_with_index { |item, index|
            good_print += print_info(item, n, index) +"\n"
            if index > 2
              break
            end
          }
          good_print


        else
          "Lita没有找到有关#{n}的信息"
        end
      end

      def print_info(pair, n, index)

        http_response = http.get(
            "https://wiki.risid.com/api.php?action=parse&page=#{URI::encode(pair['title'])}&utf8=&format=json"
        )

        text = MultiJson.load(http_response.body)['parse']['text']['*']
        doc = Nokogiri::HTML(text)


        "#{index + 1}. #{pair['title']}：#{doc.text.gsub("\n", "")} https://wiki.risid.com/index.php/#{URI::encode(pair['title'])}"
      end

      Lita.register_handler(self)
    end
  end
end
