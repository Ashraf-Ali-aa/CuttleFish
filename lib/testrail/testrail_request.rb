class TestRailRequest
  def initialize
    read_config_file
    create_object
  end

  def read_config_file
    @options    = YAML.load_file("#{$project_path}/CuttleFish/config.yml")
    @project_id = @options['project_id']
    @suite_id   = @options['suite_id']
    @section_id = @options['section_id']

    @options['base_url'] += '/' unless @options['base_url'] =~ /\/$/
    @url                  = @options['base_url']
    @user                 = @options['user']
    @password             = @options['password']
  end

  def create_object
    @client          = TestRail::APIClient.new(@url)
    @client.user     = @user
    @client.password = @password
  end
end
