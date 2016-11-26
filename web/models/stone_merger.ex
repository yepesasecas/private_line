defmodule PrivateLine.StoneMerger do

  # PrivateLine.StoneMerger.merge({:ok, %{"billing_address1" => "tu casa dir", "billing_address2" => "apto123", "billing_city" => "Lima", "billing_first_name" => "Rommel", "billing_last_name" => "Samanez"}, "<vaulted-shopper xmlns='http://ws.plimus.com'><first-name>{{{billing_first_name}}}</first-name><last-name>{{{billing_last_name}}}</last-name><payment-sources><credit-card-info><credit-card><card-number>{{{billing_address1}}}</card-number><security-code>{{{billing_address2}}}</security-code>{{{billing_city}}}<expiration-month>04</expiration-month><expiration-year>2018</expiration-year></credit-card><billing-contact-info><first-name>Juan Carlos</first-name><last-name>Lude&#xF1;a</last-name><address1>las palmas</address1><address2/><city>New York</city><state>Alaska</state><zip>99812</zip><country>PE</country></billing-contact-info></credit-card-info></payment-sources></vaulted-shopper>", ["billing_first_name", "billing_last_name", "billing_address1", "billing_address2"], ""})

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
      false -> {:ok, stone, destination_format, destination_variables, ""}
    end
  end
end
