defmodule PrivateLine.StoneDecrypt do

  # PrivateLine.StoneDecrypt.decrypt(["recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+ZdHKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFtiACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8WpIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guEQqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1uBxwN6MCURjg=="])
  # PrivateLine.StoneDecrypt.decrypt("recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+ZdHKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFtiACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8WpIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guEQqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1uBxwN6MCURjg==")

  # ------------------------------------------------------------------
  # public
  # ------------------------------------------------------------------

  def decrypt(encrypted_stone_list) when is_list(encrypted_stone_list) do
    :timer.sleep(1000)
    {:ok, encrypted_stone_list, ""}
    |> decode64
    |> decrypt_stone
    |> concat
    |> toMap
  end

  def decrypt(encrypted_stone) do
    decrypt([encrypted_stone])
  end

  # ------------------------------------------------------------------
  # private
  # ------------------------------------------------------------------

  defp decode64({:ok, stone, _msg}) do
    decoded_stone = stone
    |> Enum.map(fn(stone_piece) -> Task.async(Base, :decode64, [stone_piece]) end)
    |> Enum.map(fn(stone_piece_pid) -> Task.await(stone_piece_pid) end)

    if Enum.any?(decoded_stone, fn(piece) -> piece == :error end) do
      {:error, decoded_stone, "unable to decode64"}
    else
      {:ok, decoded_stone, ""}
    end
  end

  defp decrypt_stone({:error, stone , msg}) do
    {:error, stone , msg}
  end

  defp decrypt_stone({:ok, stone, _msg}) do
    decrypted_stone = stone
    |> Enum.map(fn({:ok, stone_piece}) -> Task.async(RsaEx, :decrypt, [stone_piece, PrivateLine.Keys.private_key]) end)
    |> Enum.map(fn(stone_piece_pid) -> Task.await(stone_piece_pid) end)
    |> Enum.map(fn({:ok, stone_piece}) -> stone_piece end)

    {:ok, decrypted_stone, ""}
  end

  defp concat({:error, stone, msg}) do
    {:error, stone , msg}
  end

  defp concat({:ok, stone_list, _msg}) do
    {:ok, Enum.join(stone_list, " "), ""}
  end

  defp toMap({:error, stone, msg}) do
    {:error, stone, msg}
  end

  defp toMap({:ok, stone, _msg}) do
    case Poison.decode(stone) do
      {:ok, stoneMap} -> {:ok, stoneMap, ""}
      {:error, _} -> {:error, stone, "No valid JSON format"}
    end
  end
end
