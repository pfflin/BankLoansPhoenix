defmodule BankLoan.LoanyTest do
  use BankLoan.DataCase

  alias BankLoan.Loany

  describe "loans" do
    alias BankLoan.Loany.Loan

    @valid_attrs %{amount: 42, email: "some email", isHigher: true, names: "some names", offer: 42, phoneNumber: "some phoneNumber"}
    @update_attrs %{amount: 43, email: "some updated email", isHigher: false, names: "some updated names", offer: 43, phoneNumber: "some updated phoneNumber"}
    @invalid_attrs %{amount: nil, email: nil, isHigher: nil, names: nil, offer: nil, phoneNumber: nil}

    def loan_fixture(attrs \\ %{}) do
      {:ok, loan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Loany.create_loan()

      loan
    end

    test "list_loans/0 returns all loans" do
      loan = loan_fixture()
      assert Loany.list_loans() == [loan]
    end

    test "get_loan!/1 returns the loan with given id" do
      loan = loan_fixture()
      assert Loany.get_loan!(loan.id) == loan
    end

    test "create_loan/1 with valid data creates a loan" do
      assert {:ok, %Loan{} = loan} = Loany.create_loan(@valid_attrs)
      assert loan.amount == 42
      assert loan.email == "some email"
      assert loan.isHigher == true
      assert loan.names == "some names"
      assert loan.offer == 42
      assert loan.phoneNumber == "some phoneNumber"
    end

    test "create_loan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Loany.create_loan(@invalid_attrs)
    end

    test "update_loan/2 with valid data updates the loan" do
      loan = loan_fixture()
      assert {:ok, %Loan{} = loan} = Loany.update_loan(loan, @update_attrs)
      assert loan.amount == 43
      assert loan.email == "some updated email"
      assert loan.isHigher == false
      assert loan.names == "some updated names"
      assert loan.offer == 43
      assert loan.phoneNumber == "some updated phoneNumber"
    end

    test "update_loan/2 with invalid data returns error changeset" do
      loan = loan_fixture()
      assert {:error, %Ecto.Changeset{}} = Loany.update_loan(loan, @invalid_attrs)
      assert loan == Loany.get_loan!(loan.id)
    end

    test "delete_loan/1 deletes the loan" do
      loan = loan_fixture()
      assert {:ok, %Loan{}} = Loany.delete_loan(loan)
      assert_raise Ecto.NoResultsError, fn -> Loany.get_loan!(loan.id) end
    end

    test "change_loan/1 returns a loan changeset" do
      loan = loan_fixture()
      assert %Ecto.Changeset{} = Loany.change_loan(loan)
    end
  end
end
