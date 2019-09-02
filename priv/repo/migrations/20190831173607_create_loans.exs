defmodule BankLoan.Repo.Migrations.CreateLoans do
  use Ecto.Migration

  def change do
    create table(:loans) do
      add :amount, :integer
      add :names, :string
      add :phoneNumber, :string
      add :email, :string
      add :offer, :integer
      add :isHigher, :boolean, default: false, null: false

      timestamps()
    end

  end
end
