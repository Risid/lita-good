module Lita
  module Handlers
    class Wiki < Handler
      # insert handler code here
      route(
          /^wiki\s+(.*)$/,
          :respond_with_info,
          command: true,
          help: {'wiki Ruby String' => '找到wikibook上关于Ruby String的信息'}
      )

      def respond_with_info(response)
        n = response.match_data.captures.first

        response.reply("Lita正在查找有关#{n}的信息")
        http_response = http.get(
            "https://zh.wikibooks.org/w/api.php?action=query&list=search&srsearch=#{URI::encode(n)}&utf8=&format=json"
        )
        data = MultiJson.load(http_response.body)
        rep_code = data["query"]['searchinfo']['totalhits']
        rep = data["query"]['search']
        if rep_code > 0
          rep.each_with_index { |item, index |
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
        "#{index+1}. #{pair['title']} https://zh.wikibooks.org/zh-hans/#{URI::encode(pair['title'])}"
      end
      Lita.register_handler(self)
    end
  end
end
