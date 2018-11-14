# frozen_string_literal: true

module Certup
  class Client
    def initialize(dnsimple:, netifly:)
      @dnsimple = dnsimple
      @netifly = netifly
      freeze
    end

    def call(hostname)
      certificate = dnsimple.find(hostname)
      result = netifly.upload(certificate)

      puts result ? "OK" : "FAIL"
    end

    private

    attr_reader :dnsimple, :netifly
  end
end
