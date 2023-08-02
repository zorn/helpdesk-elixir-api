defmodule HelpdeskWeb.Schema do
  use Absinthe.Schema

  @apis [Helpdesk.Support]

  use AshGraphql, apis: @apis

  # The query and mutation blocks is where you can add custom absinthe code
  query do
  end

  mutation do
  end
end
