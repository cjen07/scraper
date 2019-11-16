defmodule ScraperTest do
  use ExUnit.Case
  doctest Scraper

  test "httpclients and parser" do
    import Meeseeks.CSS
    html = HTTPoison.get!("http://www.baidu.com/").body
    assert length(Meeseeks.all(html, css("link"))) > 0
    assert :ok == Wallaby.start_session |> elem(0)
  end
end
