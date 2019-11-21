defmodule Validation do
  # @options [{:proxy, "localhost:1084"}]
  @options []

  def validate_url(url) do
    try do
      do_validation(url)
    rescue
      _ ->
        false
    end
  end

  def do_validation(url) do
    case HTTPoison.get(url, [], @options) do
      {:ok, resp} ->
        Map.get(resp, :status_code) == 200
      _ ->
        false
    end
  end

  def test_url_bad_case() do
    validate_url("https://www.baidu.com") |> IO.inspect()
    validate_url("https://www.baidu_not_available.com") |> IO.inspect()
  end
end