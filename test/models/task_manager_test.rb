require_relative '../test_helper'

class TaskManagerTest < Minitest::Test

  def create_tasks(num)
    num.times do |x|
      TaskManager.create({title: "my task#{x}",
                          description: "something#{x}"})
    end
  end

  def test_can_create_a_task_with_an_id
    #pass a title and description to taskmanager#create
    create_tasks(1)
    # find a task with id 1
    task = TaskManager.find(1)
    #assert that it assigned correct title and description
    assert_equal "my task0", task.title
    assert_equal "something0", task.description
    assert_equal 1, task.id
  end

  def test_can_hold_all_tasks
    create_tasks(4)

    all_tasks = TaskManager.all

    assert_equal 4, all_tasks.size
    assert_equal Task, all_tasks[0].class
  end

  def test_it_can_find_a_task_by_id
    create_tasks(3)

    task = TaskManager.find(3)

    assert_equal "my task2", task.title
    assert_equal "something2", task.description
    refute_equal "something3", task.description
  end

  def test_it_can_update_a_task
    create_tasks(1)

    updated = TaskManager.update(1, {title:"updated_title",
                                     description: "updated_description"})
    task = TaskManager.find(1)

    assert_equal "updated_title", task.title
    assert_equal "updated_description", task.description
  end

  def test_it_can_destroy_a_task
    create_tasks(3)

    all_tasks = TaskManager.all
    new_tasks = TaskManager.destroy(2)
    all_tasks2 = TaskManager.all

    assert_equal 3, all_tasks.size
    assert_equal 2, all_tasks2.size
    refute all_tasks[0].title.include?("my task1")
    refute all_tasks[1].title.include?("my task1")
  end
end
