defmodule Helpdesk.Support.Registry do
  use Ash.Registry

  entries do
    entry Helpdesk.Support.Ticket
    entry Helpdesk.Support.Representative
  end
end
