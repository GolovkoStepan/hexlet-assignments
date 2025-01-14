# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    locale = analyze_header(request) || I18n.default_locale
    I18n.locale = locale.downcase.to_sym

    @app.call(env)
  end

  def analyze_header(request)
    locale = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    Rails.logger.info("Locale found: '#{locale}'")

    I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
  end
end
