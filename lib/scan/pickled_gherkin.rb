require 'gherkin/parser'
require 'gherkin/token_scanner'
require 'gherkin/token_matcher'
require 'gherkin/ast_builder'
require 'gherkin/errors'

module PickledGherkin
  class ParsesFeatures
    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
  end

    def parse(text)
      io = StringIO.new(File.read(text))
      parser = Gherkin::Parser.new
      begin
        data = parser.parse(io)
      rescue Exception => e
        raise FeatureParseException
      end
      data
    end
  end

  class FeatureParseException < StandardError
  end
end
