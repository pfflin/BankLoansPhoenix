defmodule BankLoan.Loany.Loan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "loans" do
    field :amount, :integer
    field :email, :string
    field :isHigher, :boolean, default: false
    field :names, :string
    field :offer, :integer, default: 0
    field :phoneNumber, :string

    timestamps()
  end

  @doc false
  def changeset(loan, attrs) do
    loan
    
    |> cast(attrs, [:amount, :names, :phoneNumber, :email, :offer, :isHigher])
    |> validate_required([:amount, :names, :phoneNumber, :email, :offer, :isHigher])
    |> validate_format(:names, ~r/^[A-Z][a-z]+ ([A-Z][a-z]+\s*)*$/)
    |> validate_format(:phoneNumber, ~r/^[0-9-: ]+$/)
    |> validate_format(:email, ~r/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)
    |> custom(:amount)
    |> checkIfHigher(:isHigher)
  end 
  defp checkIfHigher(changeset, field, options \\ []) do
    value = changeset.params["isHigher"]
      if value == "true" do
        changeset
      else
        Ecto.Changeset.add_error(changeset, :isHigher, "invalid current password")
      end
  end 
  defp custom(%{params: %{} = params} = changeset, amount) do
    value = changeset.params["amount"]
    if not is_nil(value) do
      {intVal, ""} = Integer.parse(value)
        if is_prime(intVal) do
         
          put_change(changeset, :offer, round(intVal*9.99))
        else
          put_change(changeset, :offer, Enum.random(4..12)*intVal)
        end  
    else
      changeset
    end
  end 
  def is_prime(x), do: (2..x |> Enum.filter(fn a -> rem(x, a) == 0 end) |> length()) == 1
end
