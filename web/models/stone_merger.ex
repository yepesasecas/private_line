defmodule PrivateLine.StoneMerger do

  def merge({:error, stone, destination_format, destination_variables, msg}) do
    {:error, stone, destination_format, destination_variables, msg}
  end

  def merge({:ok, stone, destination_format, destination_variables, msg}) do
    {error?, destination_response} = Enum.reduce(destination_variables, {false, destination_format}, fn(var, {error?, destination_format}) ->
      case Map.fetch(stone, var) do
        {:ok, res} ->
          {error?, String.replace(destination_format, "{{{#{var}}}}", res)}
        :error ->
          {true, destination_format}
      end
    end)
    case error? do
      true -> {:error, stone, destination_format, destination_variables, "Destination Format, Variables and Stone doesnt match"}
      false -> {:ok, stone, destination_response, destination_variables, ""}
    end
  end
end
