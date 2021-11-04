defmodule ClickTest do
  use ExUnit.Case
  doctest Click

  test "most expensive click in the period for an ip" do
    test_data = [
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:02:58", amount: 7.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:02:45", amount: 11.00}
    ]

    response = Click.process(test_data)
    assert Enum.at(response, 0).amount == 11.00
  end

  test "If empty request body" do
    test_data = []

    response = Click.process(test_data)
    assert Enum.count(response) == 0
  end

  test "most recent expensive click in the period for an ip" do
    test_data = [
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:02:58", amount: 7.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:32:45", amount: 11.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:20:45", amount: 11.00}
    ]

    response = Click.process(test_data)
    timestamp = Enum.at(response, 0).timestamp
    assert timestamp.minute == 20
  end

  test "most expensive click in different period for an ip" do
    test_data = [
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:02:58", amount: 7.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:32:45", amount: 8.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:20:45", amount: 12.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 11.00}
    ]

    response = Click.process(test_data)
    assert Enum.count(response) == 2
    assert Enum.at(response, 0).amount == 8.00
    assert Enum.at(response, 1).amount == 12.00
  end

  test "Reject click if more than 10 entries in the request body" do
    test_data = [
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:02:58", amount: 7.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 02:32:45", amount: 8.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:20:45", amount: 12.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 11.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 19.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 21.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 2.50},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 11.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 3.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 03:28:45", amount: 61.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 04:28:45", amount: 10.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 06:28:45", amount: 9.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 09:28:45", amount: 2.00},
      %{ip: "22.22.22.22", timestamp: "3/11/2020 13:28:45", amount: 1.00}
    ]

    response = Click.process(test_data)
    assert Enum.count(response) == 0
  end
end
