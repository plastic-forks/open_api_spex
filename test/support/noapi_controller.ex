defmodule OpenApiSpexTest.NoApiController do
  @moduledoc false

  use Phoenix.Controller
  use OpenApiSpex.ControllerSpecs

  plug OpenApiSpex.Plug.CastAndValidate

  operation :noapi, false

  def noapi(conn, _opts) do
    conn
    |> put_status(200)
  end
end
