class Api::UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def basic_upload
    file = params[:file]

    if file
      begin
        # ext = File.extname(file.tempfile)
        cloud_image = Cloudinary::Uploader.upload(file, public_id: file.original_filename, secure: true, resource_type: :auto)
        # user.image = cloud_image['secure_url']
        puts cloud_image
        render json: { yo: "worked", file: file, cloud_image: cloud_image }
      rescue => e
        render json: { errors: e }, status: 422
        return
      end
    end
  end

  def update_user_image
    file = params[:file]
    cloud_image = basic_upload_helper(file)
    if (cloud_image)
      current_user.update(image: cloud_image['secure_url'])
      render json: { user: current_user}
    else
      render json: { error: 'Error uploading image'}, status: 422
    end
  end

  def basic_upload_helper(file)
    if file
      begin
        # ext = File.extname(file.tempfile)
        cloud_image = Cloudinary::Uploader.upload(file, public_id: file.original_filename, secure: true, resource_type: :auto)
        # user.image = cloud_image['secure_url']
        # render json: { yo: "worked", file: file, cloud_image: cloud_image }
        return cloud_image
      rescue => e
        # render json: { errors: e }, status: 422
        return false
      end
    end
  end

end
