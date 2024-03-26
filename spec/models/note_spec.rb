require 'rails_helper'

RSpec.describe Note, type: :model do

  before do
    # このファイルの全テストで使用するテストデータをセットアップする
    @user = User.create(
      first_name: 'Joe',
      last_name: 'Tester',
      email: 'joetester@example.com',
      password: 'dottle-nouveau-pavilion-tights-furze'
    )

    @project = @user.projects.create(
      name: 'Test Project'
    )
  end

  # ユーザー、プロジェクト、メッセージがあれば有効な状態であること
  it 'is valid with a user, project, and message' do
    note = Note.new(
      message: 'This is a sample note.',
      user: @user,
      project: @project
    )
    expect(note).to be_valid
  end

  # メッセージがなければ無効な状態であること
  it 'is invalid without a message' do
    note = Note.new(message: nil)
    expect(note).to be_invalid
    expect(note.errors[:message]).to include("can't be blank")
  end

  # 文字列に一致するメッセージを検索する: describe にはクラスやシステムの機能に関するアウトラインを記述
  describe 'search message for a term' do

    before do # before :each と同じで、各テストの前に実行される
      # 検索機能の全テストに関連する追加のテストデータをセットアップする
      @note1 = @project.notes.create(
        message: 'This is the first note.',
        user: @user
      )

      @note2 = @project.notes.create(
        message: 'This is the second note.',
        user: @user
      )

      @note3 = @project.notes.create(
        message: 'First, preheat the oven.',
        user: @user
      )
    end

    # 一致するデータが見つかるとき: contextには特定の状態に関するアウトラインを記述
    context 'when a match is found' do
      # 検索文字列に一致するメモを返すこと
      it 'returns notes that math the search term' do
        expect(Note.search('first')).to include(@note1, @note3)
      end
    end

    # 一致するデータが一件も見つからないとき
    context 'when no match id found' do
      it 'returns an empty collection when no results are found' do
        expect(Note.search('message')).to be_empty
      end
    end
  end
end
