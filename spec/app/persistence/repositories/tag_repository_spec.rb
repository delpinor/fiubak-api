require 'integration_helper'

describe Persistence::Repositories::TagRepository do
  let(:tag_repo) { Persistence::Repositories::TagRepository.new }
  let(:a_tag) { Tag.new('Important') }

  it 'should save a new tag' do
    tag_repo.save(a_tag)
    expect(tag_repo.all.count).to eq(1)
  end

  it 'should assign an id to a new tag' do
    new_tag = tag_repo.save(a_tag)
    expect(new_tag.id).to be_present
  end

  context 'when a tag exists' do
    before :each do
      @new_tag = tag_repo.save(a_tag)
      @tag_id = @new_tag.id
    end

    it 'should update a tag name' do
      @new_tag.replace_tag_name_with 'Critical'

      tag_repo.save(@new_tag)

      expect(tag_repo.find(@tag_id).tag_name).to eq('Critical')
    end

    it 'should not create a new tag' do
      @new_tag.replace_tag_name_with 'Paul'

      tag_repo.save(@new_tag)

      expect(tag_repo.all.count).to eq(1)
    end

    it 'should delete the tag' do
      tag_repo.delete(@new_tag)

      expect(tag_repo.all.count).to eq(0)
    end

    it 'should delete all tags' do
      tag_repo.delete_all

      expect(tag_repo.all.count).to eq(0)
    end

    it 'should find the tag by id' do
      tag = tag_repo.find(@tag_id)

      expect(tag.tag_name).to eq(@new_tag.tag_name)
    end

    it 'should find the tag by tag name' do
      not_found = -> { raise 'Test failed' }

      tag = tag_repo.find_by_tag_name(@new_tag.tag_name, &not_found)

      expect(tag.tag_name).to eq(@new_tag.tag_name)
    end

    it 'should not find the tag by tag name' do
      block_called = false
      not_found = -> { block_called = true }

      tag_repo.find_by_tag_name('Random', &not_found)

      expect(block_called).to eq(true)
    end
  end

  it 'should raise an error when attempts to find a non-existing tag' do
    expect do
      tag_repo.find(99_999)
    end.to raise_error(ObjectNotFound)
  end
end
