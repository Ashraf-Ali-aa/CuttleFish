class ScanFeatures
  @@features     = []
  @@tag_features = []

  def initialize
    @features_path        = "#{$project_path}/features"
    @feature_name_pattern = '**/**.feature'
  end

  def perform
    scan_feature_files
    scan_by_tag
  end

  def scan_feature_files
    Dir.glob(File.join(@features_path, @feature_name_pattern)).each do |feature_path|
      begin
        gherkin = Wally::ParsesFeatures.new.parse(File.read(feature_path))
        puts''
      rescue
        puts "Couldn't parse '#{feature_path}'"
        puts 'Contents:'
        puts File.read(@feature_path)
      end
      @@features << { path: feature_path, gherkin: gherkin }
    end
  end

  def scan_by_tag
    @@features.each do |feature|
      @num = true
      scan_ff_for_tag feature
      scan_scenarios_for_tag feature
    end

    finalize_scan_resuts
    Observer.set_features = @@features
    @@features
  end

  def scan_ff_for_tag(feature)
    if feature[:gherkin]['tags']
      feature[:gherkin]['tags'].each do |tag|
        next unless tag['name'] == Observer.tag
        f = feature.clone
        @@tag_features << f
        @num = false
        puts ''
      end
    end
  end

  def scan_scenarios_for_tag(feature)
    if feature[:gherkin]['elements'] && @num
      feature[:gherkin]['elements'].delete_if do |element|
        @tag = []
        if element['tags']
          element['tags'].each do |tag|
            @tag << tag['name']
          end
        end
        !@tag.include? Observer.tag
      end
    end
  end

  def finalize_scan_resuts
    @@features.delete_if do |feature|
      (feature[:gherkin]['elements'] == []) || feature[:gherkin]['elements'].nil?
    end
    @@features += @@tag_features
    @@features.uniq!
  end
end
