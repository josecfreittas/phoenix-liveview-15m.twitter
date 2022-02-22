defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={"post-#{@post.id}"} class="post">
      <div class="row">
        <div class="column column-10">
          <div class="post-avatar">
            <img src="https://via.placeholder.com/100" alt={@post.username} />
          </div>
        </div>
        <div class="column column-90 post-body">
          <span class="user_name">@<%= @post.username %></span>
          <br />
          <p><%= @post.body %></p>
        </div>
      </div>

      <div class="row actions_bar">
        <div class="column column-33 text-center">
          <a href="#" phx-click="like" phx-target={@myself}>
            <span>💟</span> <%= @post.likes_count %>
          </a>
        </div>
        <div class="column column-33 text-center">
          <a href="#" phx-click="repost" phx-target={@myself}>
            <span>🔄</span> <%= @post.reposts_count %>
          </a>
        </div>
        <div class="column column-33 text-center">
          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
            <span>✏️</span>
          <% end %>
          <span>&nbsp;&nbsp;</span>
          <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
            <span>❌</span>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("delete", _, socket) do
    {:noreply, socket}
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
