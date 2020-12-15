module Lita
  module Handlers
    class What < Handler
      # insert handler code here
      route(
          /(.*)是什么.*$/,
          :respond_with_info,
          command: true,
          help: {'中国科学院是什么' => '打印出中国科学院是什么'}
      )

      def respond_with_info(response)
        n = response.match_data.captures.first
        response.reply "Lita正在查找有关#{n}的信息"
        response.reply search_info(n)

      end

      def search_info(n)

        http_response = http.get(
            "http://shuyantech.com/api/cndbpedia/ment2ent?q=#{URI::encode(n)}"
        )
        data = MultiJson.load(http_response.body)
        rep_code = data["status"]
        rep = data["ret"]
        good_result = ""
        if rep_code == 'ok' && rep.length > 0
          if rep.length == 1 || rep[0] == n

            http_response = http.get(
                "http://shuyantech.com/api/cndbpedia/avpair?q=#{URI::encode(n)}"
            )
            data = MultiJson.load(http_response.body)
            good_result += print_info(data['ret'], n) + "\n"

          else
            good_result += "这里有多条与#{n}有关的信息，Lita需要您具体一点\n"
            data_str = ""
            rep.each { |item|
              data_str += "#{item}；"
            }
            good_result += "#{data_str}\n"
            good_result += "Lita猜测，您要找的是\n"
            good_result += rep[0]
          end
          good_result
        else
          "Lita没有找到有关#{n}的信息"
        end

      end

      def print_info(pair, n)
        data = ""
        pair.each { |item|
          if item[0] == 'DESC'
            data += "\n#{item[1]}"
          else
            data += "#{item[0]}：#{item[1]}；"
          end
        }
        if data == ""
          "Lita没有找到有关#{n}的信息"
        else
          "Lita找到如下有关#{n}的信息\n#{data}"
        end
      end

      Lita.register_handler(self)
    end
  end
end
