defmodule Helpdesk.Support.Representative do
  # This turns this module into a resource using the in memory ETS data layer
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshGraphql.Resource
    ]

  postgres do
    table "representatives"
    repo Helpdesk.Repo
  end

  actions do
    # Add the default simple actions
    defaults [:create, :update, :destroy]

    read :read do
      primary? true

      pagination(
        keyset?: true,
        default_limit: 5,
        countable: true
      )
    end
  end

  # Attributes are the simple pieces of data that exist on your resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id

    # Add a string type attribute called `:name`
    attribute :name, :string

    create_timestamp :inserted_at do
      private? false
    end

    update_timestamp :updated_at do
      private? false
    end
  end

  relationships do
    # `has_many` means that the destination attribute is not unique, therefore many related records could exist.
    # We assume that the destination attribute is `representative_id` based
    # on the module name of this resource and that the source attribute is `id`.
    has_many :tickets, Helpdesk.Support.Ticket
  end

  graphql do
    type :representative

    queries do
      get :get_representative, :read
      list :list_representatives, :read, relay?: true
    end

    mutations do
      create :create_representative, :create
      update :update_representative, :update
      destroy :destroy_representative, :destroy
    end
  end

  aggregates do
    # The first argument here is the name of the aggregate
    # The second is the relationship
    count :total_tickets, :tickets

    count :open_tickets, :tickets do
      # Here we add a filter over the data that we are aggregating
      filter expr(status == :open)
    end

    count :closed_tickets, :tickets do
      filter expr(status == :closed)
    end
  end

  calculations do
    calculate :percent_open, :float, expr(open_tickets / total_tickets)
  end
end
