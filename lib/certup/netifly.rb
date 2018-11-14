# frozen_string_literal: true

require "excon"

module Certup
  class Netifly
    def initialize(token:)
      @client = Excon.new("https://api.netlify.com/")
      @token  = token
    end

    def upload(certificate)
      response = client.post(
        path: "/api/v1/sites/#{certificate.hostname}/ssl",
        query: { access_token: token, certificate: certificate.server, ca_certificates: certificate.chain, key: certificate.private_key },
        headers: { "User-Agent" => Certup::USER_AGENT }
      )

      response.status == 200
    end

    private

    attr_reader :client, :token
  end
end
