require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe '#index' do
    context 'as an autheticated user' do
      before do
        @user = FactoryBot.create(:user)
      end

      # 正常にレスポンスを返すこと
      it 'responds successfully' do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      # 200レスポンスを返すこと
      it 'return a 200 response' do
        sign_in @user
        get :index
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      # テストをここに書く
    end
  end
end
