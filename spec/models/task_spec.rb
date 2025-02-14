require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { FactoryBot.create(:project) }
  # let を使う場合はちょっとした違いがあります。before ブロックでテストデータをセットアップする際は、インスタンス変数に格納していたことを覚えていますか?
  # let を使ったデ ータに関してはこれが当てはまりません。

  # プロジェクトと名前があれば有効な状態であること
  it 'is valid with a project and name' do
    task = Task.new(project: project, name: 'Test task')
    expect(task).to be_valid
  end

  # プロジェクトがなければ無効な状態であること
  it 'is invalid without a project' do
    task = Task.new(project: nil)
    task.valid?
    expect(task.errors[:project]).to include('must exist')
  end

  # 名前がなければ無効な状態であること
  it 'is invaid without a name' do
    task = Task.new(name: nil)
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end
end
