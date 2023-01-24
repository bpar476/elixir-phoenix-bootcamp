# Generated scaffold with mix phx.gen.schema
defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string

    timestamps()
  end

  @doc """
    First argument is a struct that contains data. This represents a record in the database (or a record to create).
    Second is a hash that contains properties we want to update the struct with.

    It tries to apply the state of attrs to the given topic filtering in attributes
    defined in the cast.

    It then validates the changeset.

    The final return value is the changeset after completing all validations

    The double backslash sets a default value for the argument
  """
  def changeset(topic, attrs \\ %{}) do
    topic
    # Cast creates the changeset. Describes how we want to update the database
    |> cast(attrs, [:title])
    # After creating the changeset, we usually apply some validators on it
    # Validators return a new changeset
    |> validate_required([:title])
  end
end
