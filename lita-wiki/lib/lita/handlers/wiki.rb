require 'resolv-replace'
require 'net/http'
module Lita
  module Handlers
    class Wiki < Handler
      # insert handler code here
      route(
          /^wiki\s+(.*)$/,
          :respond_with_info,
          command: true,
          help: {'wiki Ruby String' => '找wikipedia上关于Ruby String的信息'}
      )

      def respond_with_info(response)
        n = response.match_data.captures.first

        response.reply "Lita正在查找有关#{n}的信息"
        response.reply search_info(n)
      end


      def search_info(n)
        http_response = http.get("https://bk.tw.lvfukeji.com/w/api.php?action=query&list=search&srsearch=#{URI::encode(n)}&utf8=&format=json"
        )


        data = MultiJson.load(http_response.body)
        rep_code = data["query"]['searchinfo']['totalhits']
        rep = data["query"]['search']
        if rep_code > 0
          good_print = ""
          rep.each_with_index { |item, index|
            good_print += print_info(item, n, index) + "\n"
            if index > 4
              break
            end
          }
          good_print


        else
          "Lita没有找到有关#{n}的信息"
        end
      end

      def print_info(pair, n, index)
        "#{index+1}. #{pair['title']} https://bk.tw.lvfukeji.com/baike-#{URI::encode(pair['title'])}"
      end

      Lita.register_handler(self)
    end
  end
end
