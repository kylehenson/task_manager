require_relative '../test_helper'

class UserCreatesTaskTest < FeatureTest
  def test_create_task_with_title_and_description
    # as a guest
    # when I visit the root path
    visit '/'
    # And I click on "new task"
    click_link_or_button("New Task")
    # and I fill in the title with ____
    fill_in('task[title]', with: "Make cookies")
    # And I fill in the description with ____
    fill_in('task[description]', with: 'now')
    # And I click "submit"
    click_link_or_button('Create Task')
    # Then I should be on the task index
    assert_equal '/tasks', current_path
    # Then I should see the new task title and description
    assert page.has_content?('Make cookies')
  end

  def test_no_title_appears_when_user_does_not_enter_a_title
    # As a guest
    # When I visit the root path
    # And I click on "new task"
    # And I enter nothing into title or description
    # And I click 'submit'
    # Then I should be on the task index
    # Then I should not see a new task title or description
  end
end
