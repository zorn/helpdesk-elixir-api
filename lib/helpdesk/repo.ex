defmodule Helpdesk.Repo do
  use AshPostgres.Repo, otp_app: :helpdesk

  # Installs Postgres extensions that ash commonly uses
  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
