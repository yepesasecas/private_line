defmodule PrivateLine.StoneMerger do

  def merge({:error, stone, dest_format, dest_variables, msg}) do
    {:error, stone, dest_format, dest_variables, msg}
  end

  def merge({:ok, stone, dest_format, dest_variables, msg}) do
    {error?, dest_response} =
      Enum.reduce(dest_variables, {false, dest_format}, fn(var, {error?, dest_format}) ->
        case Map.fetch(stone, var) do
          {:ok, res} ->
            {error?, String.replace(dest_format, "{{{#{var}}}}", res)}
          :error ->
            {true, dest_format}
        end
      end)
    case error? do
      true -> {:error, stone, dest_format, dest_variables, "Destination Format, Variables and Stone doesnt match"}
      false -> {:ok, stone, dest_response, dest_variables, ""}
    end
  end
end
