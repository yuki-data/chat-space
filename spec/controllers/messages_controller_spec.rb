require 'rails_helper'

describe MessagesController do
  describe "Get #index" do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    context "ログインしていない場合" do
      it "意図したビューにリダイレクトできているか" do
        get :index, params: {group_id: group.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        login user
      end

      it "該当するビューが描画されているか" do
        get :index, params: {group_id: group.id}
        expect(response).to render_template :index
      end

      describe "アクション内で定義しているインスタンス変数があるか" do
        let(:groups) do
          groups = create_list(:group, 3)
          groups.each do |g|
            g.users << user
          end
          groups
        end
        let(:messages) { create_list(:message, 3, group: group) }

        before do
          get :index, params: {group_id: group.id}
        end

        it "@groupsがあるか" do
          expect(assigns(:groups)).to match groups
        end

        it "@groupがあるか" do
          expect(assigns(:group)).to match group
        end

        it "@messagesがあるか" do
          expect(assigns(:messages)).to match messages
        end

        it "@messageがあるか" do
          expect(assigns(:message)).to be_a_new Message
        end
      end
    end
  end
end
