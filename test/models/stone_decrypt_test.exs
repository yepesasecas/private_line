defmodule PrivateLine.StoneDecryptTest do
  use PrivateLine.ConnCase, async: true
  alias PrivateLine.StoneDecrypt

  setup_all do
    encrypted_stone = "recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+Zd" <>
                       "HKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFt" <>
                       "iACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8W" <>
                       "pIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guE" <>
                       "QqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6" <>
                       "L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1u" <>
                       "BxwN6MCURjg=="
    expected_stone = %{"billing_first_name" => "Rommel",
                        "billing_last_name" => "Samanez",
                         "billing_address1" => "tu casa dir",
                         "billing_address2" => "apto123",
                             "billing_city" => "Lima"}
    {:ok, encrypted_stone: encrypted_stone, expected_stone: expected_stone}
  end

  test "decrypt single part Stone", %{encrypted_stone: encrypted_stone, expected_stone: expected_stone} do
    {:ok, stone, _msg} = StoneDecrypt.decrypt(encrypted_stone)
    assert stone == expected_stone
  end

  test "decrypt multi part Stone", %{encrypted_stone: encrypted_stone, expected_stone: expected_stone} do
    {:ok, stone, _msg} = StoneDecrypt.decrypt(encrypted_stone)
    assert stone == expected_stone
  end

  test "unable to decode Base64 stone" do
    bad_base_64_encrypted_stone = ["___recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+Zd" <>
                                   "HKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFt" <>
                                   "iACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8W" <>
                                   "pIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guE" <>
                                   "QqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6" <>
                                   "L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1u" <>
                                   "BxwN6MCURjg=="]
    assert {:error, _stone, "unable to decode64"} = StoneDecrypt.decrypt(bad_base_64_encrypted_stone)
  end

  test "unable to decode JSON to Map Stone", %{encrypted_stone: encrypted_stone} do
    encrypted_stone = [encrypted_stone, encrypted_stone]
    assert {:error, _stone, "No valid JSON format"} = StoneDecrypt.decrypt(encrypted_stone)
  end
end
