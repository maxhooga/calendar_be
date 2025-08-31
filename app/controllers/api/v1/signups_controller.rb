# frozen_string_literal: true

module Api
  module V1
    class SignupsController < Devise::Api::TokensController
      def create
        unless Devise.api.config.sign_up.enabled
          error_response = Devise::Api::Responses::ErrorResponse.new(request, error: :sign_up_disabled, resource_class:)

          return render json: error_response.body, status: error_response.status
        end

        Devise.api.config.before_sign_up.call(sign_up_params, request, resource_class)

        service = Devise::Api::ResourceOwnerService::SignUp.new(params: sign_up_params, resource_class:).call

        if service.success?
          @token = service.success

          call_devise_trackable!(@token.resource_owner)

          token_response = Devise::Api::Responses::TokenResponse.new(request, token: @token, action: __method__)

          Devise.api.config.after_successful_sign_up.call(@token.resource_owner, @token, request)

          return render :create, status: token_response.status
        end

        error_response = Devise::Api::Responses::ErrorResponse.new(request, resource_class:, **service.failure)
        render json: { error: error_response.body[:error_description].join(', ') }, status: error_response.status
      end

      def sanitized_params
        params.fetch(:user, {})
      end

      def sign_up_params
        sanitized_params.permit(
          *Devise.api.config.sign_up.extra_fields,
          *resource_class.authentication_keys,
          *::Devise::ParameterSanitizer::DEFAULT_PERMITTED_ATTRIBUTES[:sign_up]
        ).to_h
      end
    end
  end
end
