require_relative '../test_helper'

class UserDeletesTask < FeatureTest
  def test_destroy_task_removes_task
    TaskManager.create({ title: 'Build office chair',
                         description: 'make office'})
    TaskManager.create({ title: 'Run to bank',
                         description: '$$'})
    TaskManager.destroy(1)
    # As a guest
    # When I visit the root path
    visit '/tasks'
    # And I click on 'delete task'
    click_link_or_button('Delete')
    # Then i should be on the task index
    assert_equal '/tasks/2/delete', current_path
    # Then I should see the updated list of tasks to not include deleted task
    assert page.has_content?('Run to bank')
    refute page.has_content?('Build office chair')
  end
end
