# frozen_string_literal: true

# BEGIN
require 'forwardable'

class Url
  include Comparable
  extend Forwardable

  def_delegators :@uri, :scheme, :host, :port

  def initialize(url_str)
    @uri = URI(url_str)
  end

  def query_params
    URI
      .decode_www_form(uri.query || '')
      .to_h
      .transform_keys(&:to_sym)
  end

  def query_param(key, default_value = nil)
    query_params[key] || default_value
  end

  def ==(other)
    [
      scheme       == other.scheme,
      host         == other.host,
      port         == other.port,
      query_params == other.query_params
    ].all?(true)
  end

  private

  attr_reader :uri
end
# END
