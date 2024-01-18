defmodule LunchClientWeb.Live.Home.HomeForm do
  use LunchClientWeb, :live_component
  use LiveViewNative.LiveComponent

  def form(%{format: :swiftui} = assigns) do
    ~SWIFTUI"""
      <LiveForm phx-submit="submit" id="login-form">
        <TextField name="user_name" text="Skriv in ditt namn: "/>
        <TextField name="party_name" text="Skriv in team: "/>
        <LiveSubmitButton phx-value-extra="more info">Click Me!</LiveSubmitButton>
      </LiveForm>
    """
  end

  def form(assigns) do
    ~H"""
      <form phx-submit="submit" class="flex flex-col gap-1 text-lg">
        <input type="text" name="user_name" placeholder="Skriv in namn: " class="rounded focus:border-blue"/>
        <input type="text" name="party_name" placeholder="Skriv in team: " class="rounded focus:border-blue"/>
        <input type="submit" value="Join!" class="bg-blue-500 hover:bg-blue-700 text-white font-bold rounded py-2 px-2 mt-1"/>
      </form>
    """
  end
end
