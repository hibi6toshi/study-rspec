require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  let(:user) { double('user') }
  let(:project) { instance_double('Project', owner: user, id: '123') }

  before do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(Project).to receive(:find).with('123').and_return(project)
  end

  describe 'index' do
    # 入力されたキーワードでメモを検索すること
    it 'searches notes by provided keyword' do
      expect(project).to receive_message_chain(:notes, :search).with('rotate tires')
      get :index, params: { project_id: project.id, term: 'rotate tires' }

      # ここでは receive_message_chain を使って project.notes.search を参照しています。
      # ここで覚えておいてほしいことが一つあります。それは、このエクスペクテーションはアプリケーションコードを実際に動かす前に追加しないとテストがパスしないということです。
      # ここでは allow ではなく expect を使っているので、もしこのメッセージチェーン(連続したメ ソッド呼び出し)が呼び出されなかった場合はテストが失敗します。
    end
  end
end
