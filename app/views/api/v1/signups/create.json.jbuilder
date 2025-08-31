# frozen_string_literal: true

json.access_token @token.access_token
json.refresh_token @token.refresh_token
json.expires_in @token.expires_in

if @token.resource_owner
  json.user do
    json.id @token.resource_owner.id
    json.email @token.resource_owner.email
    json.first_name @token.resource_owner.first_name
    json.last_name @token.resource_owner.last_name
    json.role @token.resource_owner.role
  end
end

if @token.resource_owner.avatar.attached?
  json.avatar do
    json.url @token.resource_owner.avatar.blob.url
    json.thumbnail_url Cloudinary::Thumbnail.call(@token.resource_owner.avatar.blob).result
    json.download_url Cloudinary::Download.call(@token.resource_owner.avatar.blob).result
    json.filename @token.resource_owner.avatar.blob.filename.sanitized
    json.content_type @token.resource_owner.avatar.blob.content_type
    if @token.resource_owner.avatar.blob.image?
      json.height @token.resource_owner.avatar.blob.metadata[:height]
      json.width @token.resource_owner.avatar.blob.metadata[:width]
    end
  end
end
