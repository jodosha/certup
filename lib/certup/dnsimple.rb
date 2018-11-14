# frozen_string_literal: true

require "dnsimple"

module Certup
  class Dnsimple
    def initialize(token:)
      @client = ::Dnsimple::Client.new(access_token: token, user_agent: Certup::USER_AGENT)
    end

    def find(hostname)
      domain = hostname.split(".").last(2).join(".")

      certificate = last_certificate(domain, hostname)
      bundle      = download_certificate(domain, certificate)
      private_key = download_private_key(domain, certificate)

      Certificate.new(
        hostname: hostname,
        server: bundle.server,
        chain: bundle.chain.join("\n"),
        private_key: private_key
      )
    end

    private

    attr_reader :client

    def account_id
      @account_id ||= client.identity.whoami.data.account.id
    end

    def last_certificate(domain, hostname)
      certificates = client.certificates.certificates(account_id, domain, sort: "expires_on:desc").data
      certificates.find { |c| c.common_name == hostname }
    end

    def download_certificate(domain, certificate)
      client.certificates.download_certificate(account_id, domain, certificate.id).data
    end

    def download_private_key(domain, certificate)
      client.certificates.certificate_private_key(account_id, domain, certificate.id).data.private_key
    end
  end
end
