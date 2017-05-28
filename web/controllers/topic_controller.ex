defmodule Discuss.TopicController do 
    use Discuss.Web, :controller

    alias Discuss.Topic 

    def index(conn, _params) do
        topics = Repo.all(Topic)

        render conn, "index.html", topics: topics
    end

    def show(conn, _params) do
        
    end

    def new(conn, _params) do
        changeset = Topic.changeset(%Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end
 
    def create(conn, %{"topic" => topic} = params) do
        changeset = Topic.changeset(%Topic{}, topic)
        
        case Repo.insert(changeset) do
           {:ok, _topic} ->
               conn
               |> put_flash(:info, "Topic Created")
               |> redirect(to: topic_path(conn, :index))
           {:error, changeset} ->
               render conn, "new.html", changeset: changeset
        end 
    end

    def edit(conn, %{"id" => topic_id}) do
        topic = Repo.get( Topic, topic_id)
        changeset = Topic.changeset(topic)
        IO.inspect(topic)
        render conn, "edit.html", changeset: changeset, topic: topic
    end

    def update(conn, %{"id" => topic_id, "topic" => topic} = params) do
        changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)

        case Repo.update(changeset) do
            {:ok, topic} ->
                conn
                |> put_flash(:info, "Topic updated")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> 
                render conn, "edit.html", changeset: changeset, topic: topic_id
        end
    end
end