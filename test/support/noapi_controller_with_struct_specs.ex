defmodule OpenApiSpexTest.NoApiControllerWithStructSpecs do
  @moduledoc false

  use Phoenix.Controller

  plug OpenApiSpex.Plug.CastAndValidate

  def open_api_operation(action) do
    apply(__MODULE__, :"#{action}_operation", [])
  end

  def noapi_operation(), do: nil

  def noapi(conn, _opts) do
    conn
    |> put_status(200)
  end
end
