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

    render(conn, "index.html", topics: topics)
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
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
  Renders a form to edit a specific topic. The topic ID is coming
  from the :id path parameter as defined in the router
  """
  def edit(conn, %{"id" => topic_id}) do
    # Fetches the topic with the given primary key value
    topic = Repo.get(Topic, topic_id)

    # Creates a changeset based on the topic with no changes
    changeset = Topic.changeset(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  @doc """
  Takes the form values for the updated topic and applies the
  update to the topic via changeset
  """
  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
