class CleanParentSection < TestRailRequest
  def perform
    all_sections       = @client.send_get("get_sections/#{@project_id}&suite_id=#{@suite_id}")
    sections_to_delete = all_sections.select { |name| name['parent_id'] == @section_id }

    sections_to_delete.each do |to_delete|
      @client.send_post("delete_section/#{to_delete['id']}", 'suite_id' => @suite_id.to_s)
      puts "\"#{to_delete['name']}\" section with id-> #{to_delete['id']} was deleted"
    end
    puts "Automated section id# #{@section_id} cleaned!!!"
  end

  def clean_all
    all_sections       = @client.send_get("get_sections/#{@project_id}&suite_id=#{@suite_id}")
    sections_to_delete = all_sections.select { |name| name['id'] }

    sections_to_delete.each do |to_delete|
      @client.send_post("delete_section/#{to_delete['id']}", 'suite_id' => @suite_id.to_s)
      puts "\"#{to_delete['name']}\" section with id-> #{to_delete['id']} was deleted"
    end
    puts "Automated section id# #{@section_id} cleaned!!!"
  end
end
