defmodule LunchClientWeb.Live.Home do
  use LunchClientWeb, :live_view
  use LiveViewNative.LiveView

  def handle_event("submit", %{ "group_name" => group_name, "user_name" => user_name}, socket) do
    pid = Lunch.new_lunch(group_name, user_name)
    Phoenix.PubSub.subscribe(:my_pubsub, "lunch:#{group_name}")
    lunch = Lunch.get(pid)
    {:noreply, assign(socket, %{ pid: pid, lunch: lunch}) }
  end

  def handle_event("get_restaurant_button_triggered", _params, socket) do
    { :noreply, assign(socket, :lunch, Lunch.get_lunch(socket.assigns.pid))}
  end

  def handle_info({:updated_lunch, lunch}, socket) do
    { :noreply, assign(socket, :lunch, lunch) }
  end

  def render(%{lunch: lunch, format: :swiftui} = assigns) do
    ~SWIFTUI"""
      <Text>Restaurant: <%= @lunch.chosen_alternative %></Text>
      <Button phx-click="get_restaurant_button_triggered">Get restaurant!</Button>
    """
  end

  def render(%{format: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack>
      <LunchClientWeb.Live.Home.HomeForm.form {assigns}/>
    </VStack>
    """
  end

  def render(%{lunch: lunch} = assigns) do
    ~H"""
    <div class="flex flex-col items-center justify-center font-bold text-8xl h-screen gap-8">
    <h1>Lurre!</h1>
    <div class="flex flex-col gap-4 justify-center items-center text-lg">
      <div class="flex">
        <p>Restaurant:</p>
        <p><%= @lunch.chosen_alternative %></p>
      </div>
      <button phx-click="get_restaurant_button_triggered" class="bg-blue-500 hover:bg-blue-700 text-white font-bold rounded py-2 px-2 mt-1">Get restaurant!</button>
    </div>
    </div>
    """
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center justify-center font-bold text-8xl h-screen gap-8">
      <h1>Lurre!</h1>
      <LunchClientWeb.Live.Home.HomeForm.form />
    </div>
    """
  end

end
