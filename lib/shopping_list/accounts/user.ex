defmodule ShoppingList.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Pbkdf2

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> update_change(:password, &Pbkdf2.hash_pwd_salt/1)
  end
end
