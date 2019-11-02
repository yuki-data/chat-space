require 'rails_helper'

describe MessagesController do
  describe "Get #index" do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    context "ログインしていない場合" do
      it "意図したビューにリダイレクトできているか" do
        get :index, params: {group_id: group.id}
        expect(response).to redirect_to "http://test.host/users/sign_in"
      end
    end

    context "ログインしている場合" do
      before do
        login user
      end

      it "アクション内で定義しているインスタンス変数があるか" do
        groups = create_list(:group, 3)
        groups.each do |g|
          g.users << user
        end
        messages = create_list(:message, 3, group: group)
        get :index, params: {group_id: group.id}
        expect(assigns(:groups)).to match groups
        expect(assigns(:group)).to eq group
        expect(assigns(:messages)).to match messages
        expect(assigns(:message)).to be_a_new Message
      end

      it "該当するビューが描画されているか" do
        get :index, params: {group_id: group.id}
        expect(response).to render_template :index
      end
    end
  end
end
