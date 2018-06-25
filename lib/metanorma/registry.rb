# Registry of all Metanorma types and entry points
#

require 'singleton'

class Error < StandardError
end

module Metanorma
  class Registry
    include Singleton

    attr_reader :processors

    def initialize
      @processors = {}
    end

    def register processor
      raise Error unless processor < ::Metanorma::Processor
      p = processor.new
      puts "[metanorma] processor \"#{p.short}\" registered"
      @processors[p.short] = p
    end

    def find_processor(short)
      @processors[short.to_sym]
    end

    def supported_backends
      @processors.keys
    end

    def processors
      @processors
    end

    def output_formats
      @processors.inject({}) do |acc, (k,v)|
        acc[k] = v.output_formats
        acc
      end
    end

  end
end
