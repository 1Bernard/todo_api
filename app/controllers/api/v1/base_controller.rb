module Api
  module V1
    class BaseController < ApplicationController
      # Things specific to how V1 works
      # 1. Handle "Known" Business Errors (Custom Class)
      rescue_from ApiError, with: :handle_api_error

      # 2. Handle Rails Standard Errors
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_error
      rescue_from ActionController::ParameterMissing, with: :handle_bad_request

      # 3. Handle "Unknown" Crashes (500)
      # Only do this in production to avoid hiding useful stack traces in dev
      rescue_from StandardError, with: :handle_server_error if Rails.env.production?

      private

      # GENERIC JSON FORMATTER
      def render_error(message, status, code = nil, details = nil)
        payload = { error: message }
        payload[:code] = code if code.present?
        payload[:details] = details if details.present?

        render json: payload, status: status
      end

      # HANDLERS

      def handle_api_error(exception)
        render_error(exception.message, exception.status, exception.code)
      end

      def handle_not_found(exception)
        render_error("Resource not found", :not_found, "resource_not_found")
      end

      def handle_validation_error(exception)
        # This gives a nice detailed object of what fields failed
        render_error(
          "Validation failed",
          :unprocessable_entity,
          "validation_error",
          exception.record.errors.as_json
        )
      end

      def handle_bad_request(exception)
        render_error(exception.message, :bad_request, "bad_request")
      end

      def handle_server_error(exception)
        # Log the real error internally so you can debug it
        Rails.logger.error(exception.message)
        Rails.logger.error(exception.backtrace.join("\n"))

        render_error("Internal Server Error", :internal_server_error, "server_error")
      end
    end
  end
end
