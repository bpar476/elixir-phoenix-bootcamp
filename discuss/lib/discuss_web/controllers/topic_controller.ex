defmodule DiscussWeb.TopicController do
  # Controllers, models, and views have a use statement like this
  # So that they can "inherit" default behaviour from a def in the
  # DiscussWeb module
  use DiscussWeb, :controller

  alias Discuss.Topic
  alias Discuss.Repo

  @doc """
  Renders a list of all topics
  """
  def index(conn, _params) do
    topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end

  @doc """
  Renders a form to create a new topic
  """
  def new(conn, _params) do
    # Create an empty changeset
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Creates a topic from a filled out New Topic form
  """
  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        IO.inspect(changeset)
        render conn, "new.html", changeset: changeset
    end
  end
end
