defmodule Helpdesk.Support.Types.TicketStatus do
  use Ash.Type.Enum, values: [:open, :closed]

  def graphql_type, do: :ticket_status
end
