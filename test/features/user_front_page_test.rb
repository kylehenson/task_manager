require_relative '../test_helper'

class FrontPageTest < FeatureTest
  def test_user_sees_welcome_message
    visit '/'
    within('#greeting') do
      assert page.has_content?("Welcome to Task Manager")
    end
  end
end
