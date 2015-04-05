require 'sequel'
require 'sqlite3'

class TaskManager

  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager.sqlite3")
    end
  end

  def self.create(task)
    data = {"title" => task[:title], "description" => task[:description]}
    database.from(:tasks).insert(data)
  end

  def self.raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def self.all
    database.from(:tasks).all.map do |raw_task|
      Task.new(raw_task)
    end
  end

  def self.raw_task(id)
    database.from(:tasks).find { |task| task[:id] == id }
  end

  def self.find(id)
    Task.new(raw_task(id))
  end

  def self.update(id, task)
    database.from(:tasks).where(:id => id).update(title: task[:title], description: task[:description])
  end

  def self.destroy(id)
    database.from(:tasks).where(:id => id).delete
  end

  def self.delete_all
    database.from(:tasks).delete
  end
end
