require 'integration_helper'

describe Persistence::Repositories::TaskRepository do
  let(:task_repo) { Persistence::Repositories::TaskRepository.new }
  let(:a_task) { Task.new(an_existing_user, 'Meeting with Paul') }
  let(:a_tag) { Tag.new('Important') }
  let(:another_tag) { Tag.new('Critical') }

  let(:a_task_with_tags) do
    a_task.add_tag(a_tag)
    a_task
  end

  it 'should save a new task' do
    task_repo.save(a_task)
    expect(task_repo.all.count).to eq(1)
  end

  it 'should assign an id to a new task' do
    new_task = task_repo.save(a_task)
    expect(new_task.id).to be_present
  end

  it 'should save a new task with a tag' do
    task = task_repo.save(a_task_with_tags)
    new_task = task_repo.find(task.id)
    expect(new_task.tags.count).to eq(1)
    expect(new_task.tags.first.tag_name).to eq(a_tag.tag_name)
  end

  it 'should add a new tag to a new task with a tag' do
    task = task_repo.save(a_task_with_tags)

    task.add_tag(another_tag)
    task_repo.save(task)

    new_task = task_repo.find(task.id)
    expect(new_task.tags.count).to eq(2)
    expect(new_task.tags.last.tag_name).to eq(another_tag.tag_name)
  end

  context 'when a task exists' do
    before :each do
      @new_task = task_repo.save(a_task)
      @task_id = @new_task.id
    end

    it 'should find all tasks' do
      expect(task_repo.all.count).to eq(1)
    end

    it 'should update a task name' do
      @new_task.replace_title_with 'Record a song'

      task_repo.save(@new_task)

      expect(task_repo.find(@task_id).title).to eq('Record a song')
    end

    it 'should not create a new task' do
      @new_task.replace_title_with 'Record a song'

      task_repo.save(@new_task)

      expect(task_repo.all.count).to eq(1)
    end

    it 'should delete the task' do
      task_repo.delete(@new_task)

      expect(task_repo.all.count).to eq(0)
    end

    it 'should delete all tasks' do
      task_repo.delete_all

      expect(task_repo.all.count).to eq(0)
    end

    it 'should find the task by id' do
      task = task_repo.find(@task_id)

      expect(task.title).to eq(@new_task.title)
    end

    it 'should add a new tag' do
      @new_task.add_tag a_tag
      task_repo.save(@new_task)

      task = task_repo.find(@task_id)
      expect(task.tags.count).to eq(1)
      expect(task.tags.first.tag_name).to eq(a_tag.tag_name)
    end
  end

  it 'should raise an error when attempts to find a non-existing task' do
    expect do
      task_repo.find(99_999)
    end.to raise_error(ObjectNotFound)
  end
end
