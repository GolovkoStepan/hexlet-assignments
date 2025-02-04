# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'net/http'

class Hacker
  TARGET_HOST  = 'https://rails-collective-blog-ru.hexlet.app'
  SIGN_UP_PATH = '/users/sign_up'
  USERS_PATH   = '/users'

  def self.hack(email, password)
    new(email, password).hack
  end

  def initialize(email, password)
    @email    = email
    @password = password
  end

  def hack
    sign_up_response            = http.get(SIGN_UP_PATH)
    cookies, authenticity_token = process_sign_up_response(sign_up_response)

    create_user_request = Net::HTTP::Post.new(USERS_PATH).tap do |request|
      request['Cookie']       = cookies
      request['Content-Type'] = 'application/x-www-form-urlencoded'
      request.body            = URI.encode_www_form(form_params(authenticity_token))
    end

    http.request(create_user_request)
  end

  private

  attr_reader :email, :password

  def uri
    @uri ||= URI(TARGET_HOST)
  end

  def http
    @http ||= Net::HTTP.new(uri.host, uri.port).tap do |instance|
      instance.use_ssl     = (uri.scheme == 'https')
      instance.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end

  def process_sign_up_response(response)
    html_document      = Nokogiri::HTML(response.body)
    authenticity_token = html_document.at('input[name="authenticity_token"]')['value']

    [response['Set-Cookie'], authenticity_token]
  end

  def form_params(authenticity_token)
    {
      'authenticity_token' => authenticity_token,
      'user[email]' => email,
      'user[password]' => password,
      'user[password_confirmation]' => password
    }
  end
end
