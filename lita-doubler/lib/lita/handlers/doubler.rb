module Lita
  module Handlers
    class Doubler < Handler
      route(
          /^double\s+(\d+)$/i,
          :respond_with_double,
          command: true,
          help: {'double N' => 'prints N + N'}
      )

      def respond_with_double(response)
        n = response.match_data.captures.first
        n = Integer(n)
        if n < 10000 && n > -10000
          response.reply "#{n} 加 #{n} 等于 #{double_number n}"
        elsif n >= 10000
          response.reply "#{n}太大了，不会算"
        else
          response.reply "#{n}太小了，不会算"
        end

      end

      def double_number(n)
        n + n

      end


      Lita.register_handler(self)
    end
  end
end
