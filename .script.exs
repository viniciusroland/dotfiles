defmodule Parser do
  def parse([filename, format_type, "sum"]) do
    parse([filename, format_type])
    |> Enum.sum()
  end
  def parse([filename, format_type]) do
    [head | _rest] = list = 
    File.read!(filename)
    |> String.split("\n")
    |> Enum.reverse()

    list = if head == "", do: tl(list), else: list

    list
    |> Enum.reverse()
    |> Enum.map(fn item -> 
      item
      |> String.trim()
      |> format(format_type)
    end)
  end
  def parse([filename]), do: parse([filename, nil])

  def format(item, "sq"), do: '#{item}'
  def format(item, "dq"), do: "#{item}"
  def format(item, "int"), do: item |> String.to_integer
  def format(item, "flt"), do: item |> String.to_float
  def format(item, _), do: item

  def copy(term) do
    text =
      if is_binary(term) do
        term
      else
        inspect(term, limit: :infinity, pretty: true)
      end

    clipboard_app = case :os.type() do
      {:win32, _} -> "clip"
      _ -> "pbcopy"
    end

    port = Port.open({:spawn, clipboard_app}, [])
    true = Port.command(port, text)
    true = Port.close(port)

    :ok
  end
end

System.argv()
|> Parser.parse() |> IO.inspect(label: "Copiado para seu clipboard")
|> Parser.copy()
