# frozen_string_literal: true

module Certup
  class Certificate
    attr_reader :hostname, :server, :chain, :private_key

    def initialize(hostname:, server:, chain:, private_key:)
      @hostname    = hostname.sub(/\Awww\./, "").freeze
      @server      = server.freeze
      @chain       = chain.freeze
      @private_key = private_key.freeze
      freeze
    end
  end
end
