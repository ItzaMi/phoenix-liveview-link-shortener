defmodule UrlShortenerWeb.LinkLiveTest do
  use UrlShortenerWeb.ConnCase

  import Phoenix.LiveViewTest
  import UrlShortener.LinksFixtures

  @create_attrs %{key: "some key", mini_link: "some mini_link", url: "some url"}
  @update_attrs %{key: "some updated key", mini_link: "some updated mini_link", url: "some updated url"}
  @invalid_attrs %{key: nil, mini_link: nil, url: nil}

  defp create_link(_) do
    link = link_fixture()
    %{link: link}
  end

  describe "Index" do
    setup [:create_link]

    test "lists all mini_links", %{conn: conn, link: link} do
      {:ok, _index_live, html} = live(conn, ~p"/mini_links")

      assert html =~ "Listing Mini links"
      assert html =~ link.key
    end

    test "saves new link", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/mini_links")

      assert index_live |> element("a", "New Link") |> render_click() =~
               "New Link"

      assert_patch(index_live, ~p"/mini_links/new")

      assert index_live
             |> form("#link-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#link-form", link: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/mini_links")

      html = render(index_live)
      assert html =~ "Link created successfully"
      assert html =~ "some key"
    end

    test "updates link in listing", %{conn: conn, link: link} do
      {:ok, index_live, _html} = live(conn, ~p"/mini_links")

      assert index_live |> element("#mini_links-#{link.id} a", "Edit") |> render_click() =~
               "Edit Link"

      assert_patch(index_live, ~p"/mini_links/#{link}/edit")

      assert index_live
             |> form("#link-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#link-form", link: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/mini_links")

      html = render(index_live)
      assert html =~ "Link updated successfully"
      assert html =~ "some updated key"
    end

    test "deletes link in listing", %{conn: conn, link: link} do
      {:ok, index_live, _html} = live(conn, ~p"/mini_links")

      assert index_live |> element("#mini_links-#{link.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mini_links-#{link.id}")
    end
  end

  describe "Show" do
    setup [:create_link]

    test "displays link", %{conn: conn, link: link} do
      {:ok, _show_live, html} = live(conn, ~p"/mini_links/#{link}")

      assert html =~ "Show Link"
      assert html =~ link.key
    end

    test "updates link within modal", %{conn: conn, link: link} do
      {:ok, show_live, _html} = live(conn, ~p"/mini_links/#{link}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Link"

      assert_patch(show_live, ~p"/mini_links/#{link}/show/edit")

      assert show_live
             |> form("#link-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#link-form", link: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/mini_links/#{link}")

      html = render(show_live)
      assert html =~ "Link updated successfully"
      assert html =~ "some updated key"
    end
  end
end
