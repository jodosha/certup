# frozen_string_literal: true

require "dotenv"
require "pathname"

module Certup
  VERSION = "0.1.0"
  USER_AGENT = "certup-#{VERSION}"

  require "certup/certificate"
  require "certup/dnsimple"
  require "certup/netifly"
  require "certup/client"

  def self.call(hostname:, env: Pathname.new(Dir.pwd).join(".env"))
    Dotenv.load(env)

    dnsimple = Certup::Dnsimple.new(token: ENV["CERTUP_DNSIMPLE_TOKEN"])
    netifly = Certup::Netifly.new(token: ENV["CERTUP_NETIFLY_TOKEN"])

    Client.new(dnsimple: dnsimple, netifly: netifly).call(hostname)
  end
end
