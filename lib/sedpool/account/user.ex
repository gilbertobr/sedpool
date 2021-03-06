defmodule Sedpool.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sedpool.Account.User
  alias Sedpool.Account.Vendedor

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :nome, :string
    field :username, :string
    field :cod_vend, :string
	has_many :vendedores, Sedpool.Account.Vendedor
#	belongs_to :vendedor, Sedpool.Account.Vendedor
	        # Virtual Fields #
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

        @required_fields ~w(email nome cod_vend password)
        @optional_fields ~w()

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(:email)
    |> validate_format(:email, ~r/@/, message: "E-mail incorreto!")
    |> validate_length(:password, min: 6, message: "Senha inferior a 6 dígitos")
    |> validate_confirmation(:password, message: "Senha não confere!")
    |> unique_constraint(:email)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      encrypted_password = Comeonin.Argon2.hashpwsalt(password)
      put_change(changeset, :password_hash, encrypted_password)
    else  
      changeset
    end
  end

end
