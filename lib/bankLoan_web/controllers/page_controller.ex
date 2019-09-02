defmodule BankLoanWeb.PageController do
  use BankLoanWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
