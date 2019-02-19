defmodule MeatGql.AccountsTest do
  use MeatGql.DataCase

  alias MeatGql.Accounts

  describe "users" do
    alias MeatGql.Accounts.User

    @valid_attrs %{
      email: "g.92oliveira@gmail.com",
      first_name: "Gustavo",
      last_name: "Oliveira",
      password: "jobs123#12333",
      password_confirmation: "jobs123#12333"
    }

    @password_not_match %{
      email: "g.92oliveira@gmail.com",
      first_name: "Gustavo",
      last_name: "Oliveira",
      password: "jobs123#1233",
      password_confirmation: "#12333"
    }

    @password_invalid_length %{
      email: "g.92oliveira@gmail.com",
      first_name: "Gustavo",
      last_name: "Oliveira",
      password: "123",
      password_confirmation: "123"
    }

    @invalid_email %{
      email: "g.92oliveiragmail.com",
      first_name: "Gustavo",
      last_name: "Oliveira",
      password: "jobs123#12333",
      password_confirmation: "jobs123#12333"
    }

    @update_attrs %{
      email: "g.92oliveiraup@gmail.com",
      first_name: "Gustavo 123",
      last_name: "Oliveira11",
      password: "jobs123#update",
      password_hash: "jobs123#update"
    }

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password_hash: nil, role: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      list = Accounts.list_users()
      [user1 | _tail] = list
      assert Enum.count(list) == 1
      assert user1.email == user.email
      assert user1.id == user.id
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "g.92oliveira@gmail.com"
    end

    test "create_user/1 with invalid email" do
      {:error, changeset} = Accounts.create_user(@invalid_email)
      assert changeset.errors == [email: {"has invalid format", [validation: :format]}]
      assert changeset.valid? == false
    end

    test "create_user/1 with password does not match" do
      {:error, changeset} = Accounts.create_user(@password_not_match)
      assert changeset.valid? == false

      assert changeset.errors == [
               password_confirmation: {"does not match confirmation", [validation: :confirmation]}
             ]
    end

    test "create_user/1 with password invalid length" do
      {:error, changeset} = Accounts.create_user(@password_invalid_length)
      assert changeset.valid? == false

      assert changeset.errors == [
               password:
                 {"should be at least %{count} character(s)",
                  [count: 6, validation: :length, kind: :min]}
             ]
    end

    test "create_user/1 with an email has already inserted" do
      user_fixture()
      {:error, changeset} = Accounts.create_user(@valid_attrs)

      assert changeset.errors == [
               email:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "users_email_index"]}
             ]

      assert changeset.valid? == false
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "g.92oliveiraup@gmail.com"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user.email == Accounts.get_user!(user.id).email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
