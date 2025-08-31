# frozen_string_literal: true

module Api
  module V1
    class LoginsController < Devise::Api::TokensController
      def create
        Devise.api.config.before_sign_in.call(sign_in_params, request, resource_class)

        service = Devise::Api::ResourceOwnerService::SignIn.new(params: sign_in_params, resource_class:).call

        if service.success?

          @token = service.success
          # session[:current_user_id] = @token.resource_owner_id

          call_devise_trackable!(@token.resource_owner)

          Devise::Api::Responses::TokenResponse.new(request, token: service.success, action: __method__)

          Devise.api.config.after_successful_sign_in.call(@token.resource_owner, @token, request)

          return render :create, status: :ok
        end

        Devise::Api::Responses::ErrorResponse.new(request, resource_class:, **service.failure)
        render json: "no login", status: :unprocessable_entity
        # respond_with_error(I18n.t('devise.api.error_response.invalid_email_or_password'), :unauthorized)
      end
    end
  end
end
