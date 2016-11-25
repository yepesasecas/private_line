defmodule PrivateLine.StoneMerger do

  def merge(stone: stone, format: format) do

  end

  defp merge_stone_with_destination_format({:error, _}, _) do
    :bad_stone
  end

  defp merge_stone_with_destination_format({:ok, decrypted_stone}, %{"destination_format" => destination_format, "destination_variables" => destination_variables}) do
    {error?, destination_response} = Enum.reduce(destination_variables, {false, destination_format}, fn(var, {error?, destination_format}) ->
      case Map.fetch(decrypted_stone, var) do
        {:ok, res} ->
          {error?, String.replace(destination_format, "{{{#{var}}}}", res)}
        :error ->
          {true, destination_format}
      end
    end)
    case error? do
      true -> :error
      false -> {:ok, destination_response}
    end
  end
end
