defmodule Model do
  def test_mongo() do
    {:ok, conn} = Mongo.start_link(url: "mongodb://database:27017/test")
    cursor = Mongo.find(conn, "my_collection", %{})
    cursor
    |> Enum.to_list()
    |> IO.inspect

    :ok
  end
end