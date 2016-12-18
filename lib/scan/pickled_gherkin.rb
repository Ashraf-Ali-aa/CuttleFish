require 'gherkin/parser'
require 'gherkin/token_scanner'
require 'gherkin/token_matcher'
require 'gherkin/ast_builder'
require 'gherkin/errors'

module PickledGherkin
  class ParsesFeatures
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
