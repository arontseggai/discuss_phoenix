defmodule Discuss.AuthController do
    use Discuss.Web, :controller
    plug Ueberauth

    def callback( %{assigns: %{ueberauth_auth: auth}} = conn, params) do
        IO.puts("+++++++++++++++++")
        IO.inspect(auth.credentials.token)
        IO.puts("+++++++++++++++++")
    end
end