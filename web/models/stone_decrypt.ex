defmodule PrivateLine.StoneDecrypt do
  # ------------------------------------------------------------------
  # public
  # ------------------------------------------------------------------

  def decrypt(encrypted_stone) when not is_list(encrypted_stone), do: decrypt([encrypted_stone])
  def decrypt(encrypted_stone) do
    {:ok, encrypted_stone, ""}
    |> decode64
    |> decrypt_stone
    |> concat
    |> to_map
  end

  # ------------------------------------------------------------------
  # private
  # ------------------------------------------------------------------

  defp decode64({:ok, stone, _msg}) do
    decoded_stone =
      stone
      |> Enum.map(fn(stone_piece) -> Task.async(Base, :decode64, [stone_piece]) end)
      |> Enum.map(fn(stone_piece_pid) -> Task.await(stone_piece_pid) end)

    if Enum.any?(decoded_stone, fn(piece) -> piece == :error end) do
      {:error, decoded_stone, "unable to decode64"}
    else
      {:ok, decoded_stone, ""}
    end
  end

  defp decrypt_stone({:error, stone , msg}), do: {:error, stone , msg}
  defp decrypt_stone({:ok, stone, _msg}) do
    decrypted_stone =
      stone
      |> Enum.map(fn({:ok, stone_piece}) -> Task.async(RsaEx, :decrypt, [stone_piece, PrivateLine.Keys.private_key]) end)
      |> Enum.map(fn(stone_piece_pid) -> Task.await(stone_piece_pid) end)
      |> Enum.map(fn({:ok, stone_piece}) -> stone_piece end)
    {:ok, decrypted_stone, ""}
  end

  defp concat({:error, stone, msg}), do: {:error, stone , msg}
  defp concat({:ok, stone_list, _msg}) do
    {:ok, Enum.join(stone_list, ""), ""}
  end

  defp to_map({:error, stone, msg}), do: {:error, stone, msg}
  defp to_map({:ok, stone, _msg}) do
    case Poison.decode(stone) do
      {:ok, stoneMap} -> {:ok, stoneMap, ""}
      {:error, _} -> {:error, stone, "No valid JSON format"}
    end
  end
end
