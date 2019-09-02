defmodule BankLoan.Repo do
  use Ecto.Repo,
    otp_app: :bankLoan,
    adapter: Ecto.Adapters.Postgres
end
