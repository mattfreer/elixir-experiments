defmodule Stocks do
  def max_profit(prices) do
    lowest = Enum.min(prices)
    index = Enum.find_index(prices, fn(p) -> p == lowest end)
    sub_list = Enum.slice(prices, index, length(prices))
    max = Enum.max(sub_list)
    max - lowest
  end
end

stock_prices_yesterday = [10, 7, 5, 8, 11, 9]

Stocks.max_profit(stock_prices_yesterday) == 6
|> IO.inspect

