require 'encryptor'
require 'nokogiri'
require 'pry'
require 'require_all'
require 'wally'
require 'yaml'

require_relative './lib/results/parse_test_results'
require_relative './lib/results/push_test_results'
require_relative './lib/run_tests'
require_relative './lib/scan/scan_features'
require_relative './lib/testrail/add_tests_to_sections'
require_relative './lib/testrail/clean_parent_section'
require_relative './lib/testrail/create_run'
require_relative './lib/testrail/create_sections'
require_relative './lib/testrail/get_sections'
require_relative './lib/testrail/observer'
require_relative './lib/testrail/testrail_request'
require_relative './lib/testrail/testrail'

class CuttleFish
  def initialize(type, tag = nil)
    $project_path = File.expand_path('..')

    Observer.set_type = type
    Observer.set_tag  = tag
    ScanFeatures.new.perform
  end

  def features
    Observer.features
  end

  def set_milestone=(milestone)
    Observer.set_milestone = milestone
  end

  def milestone
    Observer.milestone
  end

  def get_sections(suite_id = nil)
    section = GetSections.new

    section.set_suite_id(suite_id) unless suite_id.nil?
    section.perform
  end

  def create_sections
    CreateSections.new.perform
  end

  def add_tests_to_sections
    AddTestsToSections.new.perform
  end

  def create_run
    CreateRun.new.perform
  end

  def clean_parent_section
    CleanParentSection.new.perform
  end

  def run_tests(run_option = '')
    RunTests.new.perform run_option
  end

  def parse_test_results
    ParseTestResults.new.perform
  end

  def push_test_results
    PushTestResults.new.perform
  end
end
