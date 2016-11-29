class RunTests < TestRailRequest
  def perform(_run_option = '')
    case Observer.type
    when 'ios'
      # system "cd #{$project_path}/IOS_UI && #{run_option} TEST_PROFILE=#{Observer.tag.reverse.chop.reverse} ./go.sh"
    when 'android'
      # system "cd #{$project_path}/ANDROID_UI && #{run_option} TEST_PROFILE=#{Observer.tag.reverse.chop.reverse} ./go.sh"
    end
  end
end
