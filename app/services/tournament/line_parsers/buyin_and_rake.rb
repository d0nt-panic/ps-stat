module Tournament
  module LineParsers
    class BuyinAndRake < LineParser
      private

      def pattern
        %r{\$(?<buy_in>\d+\.\d+)\/\$(?<rake>\d+\.\d+)}
      end
    end
  end
end
