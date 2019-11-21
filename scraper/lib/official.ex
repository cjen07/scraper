defmodule Official do
  # import Meeseeks.CSS
  import Meeseeks.XPath
  alias Meeseeks.Result
  import Wallaby.Browser
  alias Wallaby.Query
  

  @message_field Query.text_field("sb_form_q")
  @en_button Query.css("#est_en")
  @submit_button Query.css("#sb_form_go")

  def bing(name \\ "ActionIQ", cnt \\ nil) do
    {:ok, user} = Wallaby.start_session
    session =
      user
      |> visit("https://cn.bing.com/search?ensearch=1")
      |> click(@en_button)
      |> fill_in(@message_field, with: name)
      |> resize_window(1000, 1000)
      |> click(@submit_button)
      |> find(Query.css("body"))
    html =
      session
      |> inspect()
      |> parse_raw()
    # IO.inspect(html, printable_limit: :infinity)
    url = fetch_url(html, 1, session, cnt, [])
    Wallaby.end_session(user)
    url
  end

  def bing_on_products(extra \\ "", cnt \\ nil) do
    extra =
      case extra do
        "" -> ""
        _ -> " " <> extra
      end
    Scraper.products()
    |> Enum.map(fn x -> bing(x <> extra, cnt) end)
  end

  defp fetch_url(html, number, session, cnt, urls) do
    cond do
      is_nil(cnt) and number > 5 ->
        take_screenshot(session)
        "err"
      is_integer(cnt) and length(urls) >= cnt ->
        urls
      true ->
        result = Meeseeks.all(html, xpath("//*[@id='b_results']/li[#{number}]/div[1]/div/cite"))
        cond do
          result == [] -> 
            fetch_url(html, number+1, session, cnt, urls)
          true ->
            url =
              result
              |> Enum.at(0)
              |> Result.text()
              |> delete_blanks()
              # |> get_host()
              |> (fn x -> IO.inspect(x) end).()
            cond do
              is_nil(cnt) -> url
              true -> 
                urls = [url | urls]
                fetch_url(html, number+1, session, cnt, urls) 
            end
        end
    end
  end

  defp parse_raw(data) do
    String.split(data, "<body")
    |> Enum.drop(1)
    |> (fn x -> ["" | x] end).()
    |> Enum.join("<body")
    |> String.split("body>")
    |> Enum.drop(-1)
    |> (fn x -> x ++ [""] end).()
    |> Enum.join("body>")
    |> String.trim()
  end

  defp delete_blanks(url) do
    String.replace(url, " ", "")
  end

  def get_host(url) do
    String.split(url, "/")
    |> Enum.take(3)
    |> Enum.join("/")
  end
end