require 'nokogiri'
require 'pry'
require 'require_all'
require 'yaml'
require 'gherkin/parser'

require_relative './testrail/testrail_request'

require_relative './results/parse_test_results'
require_relative './results/push_test_results'
require_relative './scan/pickled_gherkin'
require_relative './scan/scan_features'
require_relative './testrail/add_tests_to_sections'
require_relative './testrail/clean_parent_section'
require_relative './testrail/create_run'
require_relative './testrail/create_sections'
require_relative './testrail/get_sections'
require_relative './testrail/observer'

require_relative './testrail/testrail'
require_relative './tests/run_tests'

class CuttleFish
  def initialize(type, tag = nil)
    $project_path = File.expand_path('../')

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

  def clean_all_sections
    CleanParentSection.new.clean_all
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

b = CuttleFish.new('phone')
b.set_milestone = '4.5'
b.clean_parent_section
# b.create_run
# b.create_sections
# b.add_tests_to_sections
