class UsersController < ApplicationController
  def followings
    @user = User.find(params[:id])
  end
  def followers
    @user = User.find(params[:id])
  end
  def edit
    @user_edit = User.find(params[:id])
  end
  def create_follow
    user_follow_to = params[:id]
    user_follow = current_user.id
    OnFollow.create!(follower_id: user_follow, followee_id: user_follow_to)
    redirect_to user_photos_path(current_user)
  end
  def delete_follow
    user_follow_to = params[:id]
    user_follow = current_user.id
    follow = OnFollow.where(follower_id: user_follow, followee_id: user_follow_to)
    follow[0].destroy
    redirect_to user_photos_path(current_user)
  end

  def create_like
    user_like = current_user
    photo_liked_id = params[:photo_id]
    photo = Photo.find(params[:photo_id])
    LikePhoto.create!(user_id: user_like.id, photo_id: photo_liked_id)

    update_create_like photo
  end

  def update_create_like (photo)
    html_content = render_to_string(inline: <<-HTML.strip_heredoc)
    <%= turbo_frame_tag "photo_#{photo.id}", class: 'd-flex flex-row' do %>
      <%= link_to delete_like_path(photo_id: #{photo.id}), class: 'me-3' , data: {turbo_method: :delete} do %>
        <i class="fa-solid fa-heart"></i>
      <% end %>
      <p style="margin-bottom: 0;"><%= #{photo.liked_by_users.size} %></p>
    <% end %>
    HTML

    render turbo_stream:
             turbo_stream.replace("photo_#{photo.id}", html: html_content.html_safe)
  end


  def delete_like
    photo = Photo.find(params[:photo_id])
    like = LikePhoto.find_by(user_id: current_user.id, photo_id: params[:photo_id])
    like.destroy

    update_delete_like photo
  end

  def update_delete_like (photo)
    html_content = render_to_string(inline: <<-HTML.strip_heredoc)
    <%= turbo_frame_tag "photo_#{photo.id}", class: 'd-flex flex-row' do %>
      <%= link_to create_like_path(photo_id: #{photo.id}), class: 'me-3',data: {turbo_method: :post} do %>
        <i class="fa-regular fa-heart"></i>
      <% end %>
      <p style="margin-bottom: 0;"><%= #{photo.liked_by_users.size} %></p>
    <% end %>
    HTML

    render turbo_stream:
             turbo_stream.replace("photo_#{photo.id}", html: html_content.html_safe)
  end


  # Create and delete like album -->
  def create_like_album
    album = Album.find(params[:album_id])
    LikeAlbum.create!(user_id: current_user.id, album_id: album.id)

    update_create_like_album album
  end

  def update_create_like_album (album)
    html_content = render_to_string(inline: <<-HTML.strip_heredoc)
    <%= turbo_frame_tag "album_#{album.id}", class: 'd-flex flex-row' do %>
      <%= link_to delete_like_album_path(album_id: #{album.id}), class: 'me-3' , data: {turbo_method: :delete} do %>
        <i class="fa-solid fa-heart"></i>
      <% end %>
      <p style="margin-bottom: 0;"><%= #{album.liked_by_users.size} %></p>
    <% end %>
    HTML

    render turbo_stream:
             turbo_stream.replace("album_#{album.id}", html: html_content.html_safe)
  end

  def delete_like_album
    album = Album.find(params[:album_id])
    like = LikeAlbum.find_by(user_id: current_user.id, album_id: params[:album_id])
    like.destroy

    update_delete_like_album album
  end
  def update_delete_like_album (album)
    html_content = render_to_string(inline: <<-HTML.strip_heredoc)
    <%= turbo_frame_tag "album_#{album.id}", class: 'd-flex flex-row' do %>
      <%= link_to create_like_album_path(album_id: #{album.id}), class: 'me-3',data: {turbo_method: :post} do %>
        <i class="fa-regular fa-heart"></i>
      <% end %>
      <p style="margin-bottom: 0;"><%= #{album.liked_by_users.size} %></p>
    <% end %>
    HTML

    render turbo_stream:
             turbo_stream.replace("album_#{album.id}", html: html_content.html_safe)
  end

  def feeds_photos
    @followees = current_user.followees
    @pagy, @photos = pagy_countless(Photo.where(user_id: @followees.ids), items: 10)


    respond_to do |format|
      sleep(0.5)
      format.html
      format.turbo_stream
    end
  end
  def feeds_albums
    @followees = current_user.followees
  end
end
