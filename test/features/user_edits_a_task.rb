require_relative '../test_helper'

class UserEditsTask < FeatureTest
  def test_edit_task_title_and_description_by_id
    TaskManager.create({ title: 'Go hiking',
                        description: 'get outside'})
    # As a guest
    # When I visit the path for a specific task by id
    visit '/tasks/1'
    # And I click on 'edit task'
    click_link_or_button('Edit')
    # And I fill in the new title with ____
    fill_in('task[title]', with: "Go mountain biking")
    # And I fill in the new description with ____
    fill_in('task[description]', with: 'still good for you')
    # And I click 'submit'
    click_link_or_button('Edit Task')
    # Then I should be on task show
    assert_equal '/tasks/1', current_path
    # Then I should see the updated task title and description
    assert page.has_content?('Go mountain biking')
    refute page.has_content?('Go hiking')
  end
end
