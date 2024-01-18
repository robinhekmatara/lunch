defmodule LunchClientWeb.Layouts do
  use LunchClientWeb, :html
  use LiveViewNative.Layouts

  embed_templates "layouts/*.html"
end
