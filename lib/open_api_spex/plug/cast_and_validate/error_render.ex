defmodule OpenApiSpex.Plug.CastAndValidate.ErrorRender do
  @moduledoc """
  The behaviour for error render.
  """

  alias Plug.Conn

  @callback render(Conn.t(), list()) :: Conn.t()
end

defmodule OpenApiSpex.Plug.CastAndValidate.ErrorRender.JSON do
  @moduledoc """
  Renders errors using a quasi-json:api-compliant data shape.
  """

  alias Plug.Conn
  alias OpenApiSpex.OpenApi

  @behaviour OpenApiSpex.Plug.CastAndValidate.ErrorRender

  @impl true
  def render(%Conn{} = conn, errors) when is_list(errors) do
    json = %{
      errors: Enum.map(errors, &render_error/1)
    }

    resp = OpenApi.json_encoder().encode!(json)

    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(422, resp)
  end

  defp render_error(error) do
    pointer = OpenApiSpex.path_to_string(error)

    %{
      title: "Invalid value",
      source: %{
        pointer: pointer
      },
      detail: to_string(error)
    }
  end
end
