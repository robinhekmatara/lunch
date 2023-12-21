defmodule LunchClientWeb.Live.Home.HomeForm do
  use Phoenix.Component

  def form(assigns) do
    ~H"""
      <form phx-submit="submit" class="flex flex-col gap-1 text-lg">
        <input type="text" name="user_name" placeholder="Skriv in namn: " class="rounded focus:border-blue"/>
        <input type="text" name="group_name" placeholder="Skriv in team: " class="rounded focus:border-blue"/>
        <input type="submit" value="Join!" class="bg-blue-500 hover:bg-blue-700 text-white font-bold rounded py-2 px-2 mt-1"/>
      </form>
    """
  end
end
