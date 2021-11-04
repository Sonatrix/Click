defmodule Processor do
  @moduledoc """
  We are processing the list of clicks based on requirement provided.
  """

  def convert_timestamp_to_datetime(timestamp) do
    [date, time] = String.split(timestamp, " ", trim: true)
    [d, m, y] = String.split(date, "/", trim: true) |> Enum.map(&String.to_integer/1)
    [h, mm, s] = String.split(time, ":", trim: true) |> Enum.map(&String.to_integer/1)
    DateTime.new!(Date.from_erl!({y, d, m}), Time.from_erl!({h, mm, s}), "Etc/UTC")
  end
end
