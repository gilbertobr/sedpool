defmodule SedpoolWeb.ErrorView do
  use SedpoolWeb, :view

  def render("404.html", _assigns) do
	render "not_found.html", %{}
#    "Page not found"
  end

  def render("500.html", _assigns) do
	render "erro_internal.html", %{}
#    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
