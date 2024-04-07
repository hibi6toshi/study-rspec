require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  # ユーザー、プロジェクト、メッセージがあれば有効な状態であること
  it 'is valid with a user, project, and message' do
    note = Note.new(
      message: 'This is a sample note.',
      user: user,
      project: project
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

    # let! はブロックを即座に実行する。
    let!(:note1) {
      FactoryBot.create(
        :note,
        project: project,
        user: user,
        message: 'This is the first note.'
      )
    }

    let!(:note2) {
      FactoryBot.create(
        :note,
        project: project,
        user: user,
        message: 'This is the second note.'
      )
    }

    let!(:note3) {
      FactoryBot.create(
        :note,
        project: project,
        user: user,
        message: 'First, preheat the oven.'
      )
    }

    # 一致するデータが見つかるとき: contextには特定の状態に関するアウトラインを記述
    context 'when a match is found' do
      # 検索文字列に一致するメモを返すこと
      it 'returns notes that math the search term' do
        expect(Note.search('first')).to include(note1, note3)
      end
    end

    # 一致するデータが一件も見つからないとき
    context 'when no match id found' do
      it 'returns an empty collection when no results are found' do
        # 明示的に　note1 〜 note3　を明示的に参照する。
        expect(Note.search('message')).to be_empty
        expect(Note.count).to eq 3
      end
    end
  end

  # 名前の取得をメモを作成したユーザーに委譲すること
  it 'delegates name to the user who created it' do
    # instance_doubleは検証機能付きのテストダブル(verified double)。　インスタンスメソッドとして、nameを持っているかを検証してくれる。
    user = instance_double('User', name: 'Faker User')
    note = Note.new
    allow(note).to receive(:user).and_return(user)
    expect(note.user_name).to eq 'Faker User'

    # このコードでは モックの ユーザーオブジェクトと、テスト対象のメモに設定したスタブメソッドを使っています。
    # ここでは永続化したユーザーオブジェクトをテストダブルに置き換えています。テストダブルは本物のユーザーではありません。

    # テストダブルはfirst_nameに反応する方法を知らないので、以下のエクスペクテーションは失敗する。
    # expect(note.user.first_name).to eq 'Fake'
  end
end
