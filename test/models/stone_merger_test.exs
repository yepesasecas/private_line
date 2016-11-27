defmodule PrivateLine.StoneMergerTest do
  use PrivateLine.ConnCase, async: true
  alias PrivateLine.StoneMerger
  alias PrivateLine.StoneDecrypt

  setup_all do
    encrypted_stone = ["recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+Zd" <>
                       "HKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFt" <>
                       "iACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8W" <>
                       "pIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guE" <>
                       "QqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6" <>
                       "L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1u" <>
                       "BxwN6MCURjg=="]
    destination_format = "<vaulted-shopper xmlns='http://ws.plimus.com'><first-name>" <>
                         "{{{billing_first_name}}}</first-name><last-name>{{{billing_last_name}}}</last-name>" <>
                         "<payment-sources><credit-card-info><credit-card><card-number>{{{billing_address1}}}</card-number>" <>
                         "<security-code>{{{billing_address2}}}</security-code>{{{billing_city}}}" <>
                         "<expiration-month>04</expiration-month><expiration-year>2018</expiration-year>" <>
                         "</credit-card><billing-contact-info><first-name>Juan Carlos</first-name>" <>
                         "<last-name>Lude&#xF1;a</last-name><address1>las palmas</address1><address2/>" <>
                         "<city>New York</city><state>Alaska</state><zip>99812</zip><country>PE</country>" <>
                         "</billing-contact-info></credit-card-info></payment-sources></vaulted-shopper>"
    destination_variables = ["billing_first_name", "billing_last_name", "billing_address1", "billing_address2", "billing_city"]
    {:ok, encrypted_stone: encrypted_stone,
          destination_format: destination_format,
          destination_variables: destination_variables }
  end

  test "merge stone with destination format", %{encrypted_stone: encrypted_stone, destination_format: destination_format, destination_variables: destination_variables} do
    expected_destination_format = "<vaulted-shopper xmlns='http://ws.plimus.com'><first-name>" <>
                                  "Rommel</first-name><last-name>Samanez</last-name>" <>
                                  "<payment-sources><credit-card-info><credit-card><card-number>tu casa dir</card-number>" <>
                                  "<security-code>apto123</security-code>Lima" <>
                                  "<expiration-month>04</expiration-month><expiration-year>2018</expiration-year>" <>
                                  "</credit-card><billing-contact-info><first-name>Juan Carlos</first-name>" <>
                                  "<last-name>Lude&#xF1;a</last-name><address1>las palmas</address1><address2/>" <>
                                  "<city>New York</city><state>Alaska</state><zip>99812</zip><country>PE</country>" <>
                                  "</billing-contact-info></credit-card-info></payment-sources></vaulted-shopper>"
    {:ok, stone, _msg} = StoneDecrypt.decrypt(encrypted_stone)
    assert {:ok, _stone, ^expected_destination_format, _variables, _msg} = StoneMerger.merge({:ok, stone, destination_format, destination_variables, "msg"})
  end

  test "merge invalid stone with destination format", %{destination_format: destination_format, destination_variables: destination_variables} do
    bad_base_64_encrypted_stone = ["___recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+Zd" <>
                                   "HKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFt" <>
                                   "iACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8W" <>
                                   "pIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guE" <>
                                   "QqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6" <>
                                   "L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1u" <>
                                   "BxwN6MCURjg=="]
    {status, stone, msg} = StoneDecrypt.decrypt(bad_base_64_encrypted_stone)
    assert {:error, _stone, _expected_destination_format, _variables, "unable to decode64"} = StoneMerger.merge({status, stone, destination_format, destination_variables, msg})
  end

  test "merge stone with invlaid destination variables", %{encrypted_stone: encrypted_stone, destination_format: destination_format} do
    invalid_destination_variables = ["UNKNOWN VARIABLE", "billing_last_name", "billing_address1", "billing_address2", "billing_city"]
    {status, stone, msg} = StoneDecrypt.decrypt(encrypted_stone)
    assert {:error, _stone, _expected_destination_format, _variables, "Destination Format, Variables and Stone doesnt match"} = StoneMerger.merge({status, stone, destination_format, invalid_destination_variables, msg})
  end
end
