defmodule DilongWeb.BlogLive.Index do
  use DilongWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{name: "Matt"})}
  end
end
