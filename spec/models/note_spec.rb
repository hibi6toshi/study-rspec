require 'rails_helper'

RSpec.describe Note, type: :model do

  before do
    # このファイルの全テストで使用するテストデータをセットアップする
  end

  # 検索文字列に一致するメモを返すこと
  it 'returns notes that much the search term' do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: 'joetester@example.com',
      password: 'dotle-nouveau-pavilion-tighs-furze',
    )

    project = user.projects.create(
      name: 'Test Project'
    )

    note1 = project.notes.create(
      message: 'This is the first note.',
      user: user
    )

    note2 = project.notes.create(
      message: 'This is the second note.',
      user: user
    )

    note3 = project.notes.create(
      message: 'First, preheat the oven',
      user: user
    )

    expect(Note.search('first')).to include(note1, note3)
    expect(Note.search('first')).to_not include(note2)
  end

  # 検索結果が1件も見つからなければ空のコレクションを返すこと
  it 'returns an empty collection when no results are found' do
    user = User.create(
      first_name: 'Joe',
      last_name: "Tester",
      email: 'joetester@example.com',
      password: 'dottle-nouveau-pavilion-tights-furze',
    )

    project = user.projects.create(
      name: 'Test Project'
    )

    note1 = project.notes.create(
      message: 'This is the first note.',
      user: user
    )

    note2 = project.notes.create(
      message: 'This is the second note.',
      user: user
    )

    note3 = project.notes.create(
      message: 'First, preheat the oven.',
      user: user
    )

    expect(Note.search('message')).to be_empty
  end

  # 文字列に一致するメッセージを検索する: describe にはクラスやシステムの機能に関するアウトラインを記述
  describe 'search message for a term' do

    before do # before :each と同じで、各テストの前に実行される
      # 検索機能の全テストに関連する追加のテストデータをセットアップする
    end


    # 一致するデータが見つかるとき: contextには特定の状態に関するアウトラインを記述
    context 'when a match is found' do
      # 一致する場合の example　が並ぶ
    end

    # 一致するデータが一件も見つからないとき
    context 'when no match id found' do
      # 一致しない場合の example が並ぶ
    end
  end
end
