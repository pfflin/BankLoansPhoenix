defmodule BankLoanWeb.LoanController do
  use BankLoanWeb, :controller

  alias BankLoan.Loany
  alias BankLoan.Loany.Loan

  def index(conn, _params) do
    loans = Loany.list_loans()
    render(conn, "index.html", loans: loans)
  end

  def new(conn, _params) do
    changeset = Loany.change_loan(%Loan{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"loan" => loan_params}) do
    case Loany.create_loan(loan_params) do
      {:ok, loan} ->
        conn
        |> put_flash(:info, "Thank you for your offer")
        |> redirect(to: Routes.loan_path(conn, :show, loan))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
        :timer.apply_interval(3000, render(conn, "new.html", changeset: Loany.change_loan(%Loan{})))
    end
  end
  def reject(conn) do
    render(conn, "reject.html")
  end

  def show(conn, %{"id" => id}) do
    loan = Loany.get_loan!(id)
    render(conn, "show.html", loan: loan)
  end

  def edit(conn, %{"id" => id}) do
    loan = Loany.get_loan!(id)
    changeset = Loany.change_loan(loan)
    render(conn, "edit.html", loan: loan, changeset: changeset)
  end

  def update(conn, %{"id" => id, "loan" => loan_params}) do
    loan = Loany.get_loan!(id)

    case Loany.update_loan(loan, loan_params) do
      {:ok, loan} ->
        conn
        |> put_flash(:info, "Loan updated successfully.")
        |> redirect(to: Routes.loan_path(conn, :show, loan))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", loan: loan, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    loan = Loany.get_loan!(id)
    {:ok, _loan} = Loany.delete_loan(loan)

    conn
    |> put_flash(:info, "Loan deleted successfully.")
    |> redirect(to: Routes.loan_path(conn, :index))
  end
end