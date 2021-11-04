defmodule Click do
  @type click :: %{ip: String.t(), timestamp: Calendar.datetime(), amount: float()}
  @moduledoc """
  A click ​is the composite of an IP address, a timestamp, and a click amount
  """

  @doc """
  Create a new Click with value as the given 'data'
  """
  @spec new(any) :: click
  def new(data) do
    timestamp = data.timestamp |> Processor.convert_timestamp_to_datetime()
    %{ip: data.ip, timestamp: timestamp, amount: data.amount}
  end

  @doc """
  It will process click json and returns the resultset
  We will filter if an IP has more than 10 clicks in a day
  """
  def process(data) do
    data
    |> Stream.map(fn x -> new(x) end)
    |> Enum.group_by(fn x -> x.ip end)
    |> Enum.reject(fn {_, v} -> Enum.count(v) >= 10 end)
    |> Enum.map_every(1, fn {_, v} ->
      result = v |> Enum.group_by(&by_period(&1))

      result
      |> Enum.map_every(1, fn {_, val} ->
        Enum.max_by(Enum.sort(val, &(Timex.diff(&1.timestamp, &2.timestamp) < 0)), & &1.amount)
      end)
    end)
    |> Enum.flat_map(fn
      x when is_list(x) -> x
      x -> [x]
    end)
  end

  @doc """
  This method used to distribute record based on hour time in the period
  """
  def by_period(%{timestamp: timestamp}) do
    hour_time = timestamp.hour

    cond do
      hour_time >= 0 and hour_time < 1 -> "P1"
      hour_time >= 1 and hour_time < 2 -> "P2"
      hour_time >= 2 and hour_time < 3 -> "P3"
      hour_time >= 3 and hour_time < 4 -> "P4"
      hour_time >= 4 and hour_time < 5 -> "P5"
      hour_time >= 5 and hour_time < 6 -> "P6"
      hour_time >= 6 and hour_time < 7 -> "P7"
      hour_time >= 7 and hour_time < 8 -> "P8"
      hour_time >= 8 and hour_time < 9 -> "P9"
      hour_time >= 9 and hour_time < 10 -> "P10"
      hour_time >= 10 and hour_time < 11 -> "P11"
      hour_time >= 11 and hour_time < 12 -> "P12"
      hour_time >= 12 and hour_time < 13 -> "P13"
      hour_time >= 13 and hour_time < 14 -> "P14"
      hour_time >= 14 and hour_time < 15 -> "P15"
      hour_time >= 15 and hour_time < 16 -> "P16"
      hour_time >= 16 and hour_time < 17 -> "P17"
      hour_time >= 17 and hour_time < 18 -> "P18"
      hour_time >= 18 and hour_time < 19 -> "P19"
      hour_time >= 19 and hour_time < 20 -> "P20"
      hour_time >= 20 and hour_time < 21 -> "P21"
      hour_time >= 21 and hour_time < 22 -> "P22"
      hour_time >= 22 and hour_time < 23 -> "P23"
      hour_time >= 23 and hour_time < 24 -> "P24"
      true -> nil
    end
  end
end
