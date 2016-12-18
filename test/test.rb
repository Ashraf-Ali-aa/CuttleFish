require 'pp'
require 'gherkin/pickles/compiler'
require 'gherkin/parser'
require 'json'

data = { path: '/Users/aal29/Github/Personal/features/Download/Test3.feature',
         gherkin:    { type: :GherkinDocument,
                       feature:      { type: :Feature,
                                       tags:        [{ type: :Tag, location: { line: 1, column: 1 }, name: '@download' },
                                                     { type: :Tag, location: { line: 1, column: 11 }, name: '@wip' },
                                                     { type: :Tag, location: { line: 1, column: 16 }, name: '@test' }],
                                       location: { line: 2, column: 1 },
                                       language: 'en',
                                       keyword: 'Feature',
                                       name: "Test scenario addition if it doesn't exist",
                                       children:        [{ type: :Background,
                                                           location: { line: 4, column: 1 },
                                                           keyword: 'Background',
                                                           name: 'testing scenario addition',
                                                           steps:           [{ type: :Step,
                                                                               location: { line: 5, column: 3 },
                                                                               keyword: 'Given ',
                                                                               text: 'number 100 is my first number' }] },
                                                         { type: :Scenario,
                                                           tags:           [{ type: :Tag, location: { line: 7, column: 1 }, name: '@test1' },
                                                                            { type: :Tag, location: { line: 7, column: 8 }, name: '@live' }],
                                                           location: { line: 8, column: 2 },
                                                           keyword: 'Scenario',
                                                           name:           'Test scenario 1 - to test if a background, and a tag is provided before the scenario',
                                                           steps:           [{ type: :Step,
                                                                               location: { line: 9, column: 3 },
                                                                               keyword: 'Given ',
                                                                               text: 'number 1 is my first number' },
                                                                             { type: :Step,
                                                                               location: { line: 10, column: 3 },
                                                                               keyword: 'And ',
                                                                               text: 'a number 2 is my second number' },
                                                                             { type: :Step,
                                                                               location: { line: 11, column: 3 },
                                                                               keyword: 'Then ',
                                                                               text: 'sum is 3' }] },
                                                         { type: :Scenario,
                                                           tags:           [{ type: :Tag, location: { line: 13, column: 1 }, name: '@test2' }],
                                                           location: { line: 14, column: 1 },
                                                           keyword: 'Scenario',
                                                           name: 'Test scenario 2',
                                                           steps:           [{ type: :Step,
                                                                               location: { line: 15, column: 3 },
                                                                               keyword: 'Given ',
                                                                               text: 'number 3 is my first number' },
                                                                             { type: :Step,
                                                                               location: { line: 16, column: 3 },
                                                                               keyword: 'And ',
                                                                               text: 'a number 2 is my second number' },
                                                                             { type: :Step,
                                                                               location: { line: 17, column: 3 },
                                                                               keyword: 'Then ',
                                                                               text: 'substraction is 1' }] }] },
                       comments: [] } }

data_array = data[:gherkin][:feature]

pp feature_type = data_array[:type]
pp feature_name = data_array[:name]
pp feature_tags = data_array[:tags].flat_map { |key| key[:name] if key.include? :name }
pp feature_language = data_array[:language]

data_array[:children].each do |bdd|
  pp bdd[:type]
  pp bdd[:tags].to_hash
  pp bdd[:name]
end
# # pp data_array[:children][:name]
# # pp data_array[:children]
# pp'----'
# # pp data_array
